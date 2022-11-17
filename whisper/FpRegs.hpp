// Copyright 2020 Western Digital Corporation or its affiliates.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


#pragma once

#include <cstdint>
#include <cstddef>
#include <vector>
#include <type_traits>
#include <unordered_map>
#include <string>
#include <limits>

namespace WdRiscv
{

    /// Symbolic names of the integer registers.
    enum FpRegNumber
      {
	RegF0   = 0,
	RegF1   = 1,
	RegF2   = 2,
	RegF3   = 3,
	RegF4   = 4,
	RegF5   = 5,
	RegF6   = 6,
	RegF7   = 7,
	RegF8   = 8,
	RegF9   = 9,
	RegF10  = 10,
	RegF11  = 11,
	RegF12  = 12,
	RegF13  = 13,
	RegF14  = 14,
	RegF15  = 15,
	RegF16  = 16,
	RegF17  = 17,
	RegF18  = 18,
	RegF19  = 19,
	RegF20  = 20,
	RegF21  = 21,
	RegF22  = 22,
	RegF23  = 23,
	RegF24  = 24,
	RegF25  = 25,
	RegF26  = 26,
	RegF27  = 27,
	RegF28  = 28,
	RegF29  = 29,
	RegF30  = 30,
	RegF31  = 31,
	RegFt0  = RegF0,
	RegFt1  = RegF1,
	RegFt2  = RegF2,
	RegFt3  = RegF3,
	RegFt4  = RegF4,
	RegFt5  = RegF5,
	RegFt6  = RegF6,
	RegFt7  = RegF7,
	RegFs0  = RegF8,
	RegFs1  = RegF9,
	RegFa0  = RegF10,
	RegFa1  = RegF11,
	RegFa2  = RegF12,
	RegFa3  = RegF13,
	RegFa4  = RegF14,
	RegFa5  = RegF15,
	RegFa6  = RegF16,
	RegFa7  = RegF17,
	RegFs2  = RegF18,
	RegFs3  = RegF19,
	RegFs4  = RegF20,
	RegFs5  = RegF21,
	RegFs6  = RegF22,
	RegFs7  = RegF23,
	RegFs8  = RegF24,
	RegFs9  = RegF25,
	RegFs10 = RegF26,
	RegFs11 = RegF27,
	RegFt8  = RegF28,
	RegFt9  = RegF29,
	RegFt10 = RegF30,
	RegFt11 = RegF31
      };


  /// RISCV floating point rounding modes.
  enum class RoundingMode : uint32_t
    {
      NearestEven,     // Round to nearest, ties to even
      Zero,            // Round towards zero.
      Down,            // Round down (towards negative infinity)
      Up,              // Round up (towards positive infinity)
      NearestMax,      // Round to nearest, ties to max magnitude
      Invalid1,
      Invalid2,
      Dynamic,
      FcsrMask = 0xe0, // Mask of mode-bits in FCSR.
      FcsrShift = 5    // Index of least-significant mode bit in FCSR.
    };


  /// RISCV floating point exception flags.
  enum class FpFlags : uint32_t
    {
      None = 0,
      Inexact = 1,
      Underflow = 2,
      Overflow = 4,
      DivByZero = 8,
      Invalid = 16,
      FcsrMask = 0x1f   // Mask of flag-bits in the FCSR.
    };


  /// RISCV values used to synthesize the results of the classify
  /// instructions (e.g. flcass.s).
  enum class FpClassifyMasks : uint32_t
    {
     NegInfinity  = 1,       // bit 0
     NegNormal    = 1 << 1,  // bit 1
     NegSubnormal = 1 << 2,  // bit 2
     NegZero      = 1 << 3,  // bit 3
     PosZero      = 1 << 4,  // bit 4
     PosSubnormal = 1 << 5,  // bit 5
     PosNormal    = 1 << 6,  // bit 6
     PosInfinity  = 1 << 7,  // bit 7
     SignalingNan = 1 << 8,  // bit 8
     QuietNan     = 1 << 9   // bit 9
    };

  /// Values of FS field in mstatus.
  enum class FpFs : uint32_t
    {
     Off = 0,
     Initial = 1,
     Clean = 2,
     Dirty = 3
    };

  template <typename URV>
  class Hart;

  /// Model a RISCV floating point register file. We use double precision
  /// representation for each register and nan-boxing for single precision
  /// values.
  class FpRegs
  {
  public:

    friend class Hart<uint32_t>;
    friend class Hart<uint64_t>;

    /// Constructor: Define a register file with the given number of
    /// registers. All registers initialized to zero.
    FpRegs(unsigned registerCount);

    /// Destructor.
    ~FpRegs()
    { regs_.clear(); }
    
    /// Return value of ith register.
    double readDouble(unsigned i) const
    { return regs_[i]; }

    /// Return the bit pattern of the ith register as an unsigned
    /// integer. If the register contains a nan-boxed value, return
    /// that value without the box.
    uint64_t readBitsUnboxed(unsigned i) const
    {
      FpUnion u{regs_.at(i)};
      if (nanBox_ and u.sp.pad == ~uint32_t(0))
        u.sp.pad = 0;

      return u.i64;
    }

    /// Return true if given value represents a nan-boxed single
    /// precision value.
    bool isNanBoxed(uint64_t value) const
    {
      if (not nanBox_)
        return false;
      FpUnion u{value};
      return u.sp.pad == ~uint32_t(0);
    }

    /// Return the bit pattern of the ith register as an unsigned
    /// integer. If the register contains a nan-boxed value, do not
    /// unbox it (return the 64-bit NaN).
    uint64_t readBitsRaw(unsigned i) const
    {
      FpUnion u {regs_.at(i)};
      if (flen_ == 32)
        u.sp.pad = 0;
      return u.i64;
    }

    /// Set FP register i to the given value.
    void pokeBits(unsigned i, uint64_t val)
    {
      FpUnion fpu(val);
      regs_.at(i) = fpu.dp;
    }

    /// Set value of ith register to the given value.
    void writeDouble(unsigned i, double value)
    {
      originalValue_ = regs_.at(i);
      regs_.at(i) = value;
      lastWrittenReg_ = i;
    }

    /// Read a single precision floating point number from the ith
    /// register.  If the register width is 64-bit, this will recover
    /// the least significant 32 bits (it assumes that the number in
    /// the register is NAN-boxed). If the register width is 32-bit,
    /// this will simply recover the number in it.
    float readSingle(unsigned i) const;

    /// Write a single precision number into the ith register. NAN-box
    /// the number if the register is 64-bit wide.
    void writeSingle(unsigned i, float x);

    /// Return the count of registers in this register file.
    size_t size() const
    { return regs_.size(); }

    /// Set ix to the number of the register corresponding to the
    /// given name returning true on success and false if no such
    /// register.  For example, if name is "f2" then ix will be set to
    /// 2. If name is "fa0" then ix will be set to 10.
    bool findReg(const std::string& name, unsigned& ix) const;

    /// Return the name of the given register.
    std::string regName(unsigned i, bool abiNames = false) const
    {
      if (abiNames)
	{
	  if (i < numberToAbiName_.size())
	    return numberToAbiName_[i];
	  return std::string("f?");
	}
      if (i < numberToName_.size())
	return numberToName_[i];
      return std::string("f?");
    }

  protected:

    void reset(bool isDouble)
    {
      if (isDouble)
        {
          for (auto& reg : regs_)
            reg = 0;
        }
      else
        {
          // Only F extension present. Reset to NAN-boxed zeros if
          // flen is 64.
          for (size_t i = 0; i < regs_.size(); ++i)
            writeSingle(i, 0);
        }

      clearLastWrittenReg();
    }

    /// Clear the number denoting the last written register.
    void clearLastWrittenReg()
    { lastWrittenReg_ = -1; lastFpFlags_ = 0; }

    /// Return the number of the last written register or -1 if no register has
    /// been written since the last clearLastWrittenReg.
    int getLastWrittenReg() const
    { return lastWrittenReg_; }

    /// Set regIx and regValue to the index and previous value (before
    /// write) of the last written register returning true on success
    /// and false if no integer was written by the last executed
    /// instruction (in which case regIx and regVal are left
    /// unmodified).
    bool getLastWrittenReg(unsigned& regIx, uint64_t& regValue) const
    {
      if (lastWrittenReg_ < 0) return false;
      regIx = lastWrittenReg_;

      // Copy bits of last written value inot regValue
      union
      {
        double d;
        uint64_t u;
      } tmp;
      tmp.d = originalValue_;
      regValue = tmp.u;

      return true;
    }

    /// Return the incremental floating point flag values resulting from
    /// the execution of the last instruction. Return 0 if last instructions
    /// is not an FP instruction or if it does not set any of the FP flags.
    unsigned getLastFpFlags() const
    { return lastFpFlags_; }

    /// Set the incremental FP flags produced by the last executed FP
    /// instruction.
    void setLastFpFlags(unsigned flags)
    { lastFpFlags_ = flags; }

    /// Set width of floating point register (flen). Internal
    /// representation always uses 64-bits. If flen is set to 32 then
    /// nan-boxing is not done. Return true on success and false
    /// on failure (fail if length is neither 32 or 64).
    /// Flen should not be set to 32 if D extension is enabled.
    bool setFlen(unsigned length)
    {
      if (length != 32 and length != 64)
        return false;
      flen_ = length;
      nanBox_ = (flen_ == 64);
      return true;
    }

  private:

    // Single precision number with a 32-bit padding.
    struct SpPad
    {
      SpPad(float x)  : sp(x), pad(0) { }

      float sp;
      uint32_t pad;
    };

    // Union of double and single precision numbers used for NAN boxing.
    union FpUnion
    {
      FpUnion(double x)   : dp(x)  { }
      FpUnion(uint64_t x) : i64(x) { }
      FpUnion(float x)    : sp(x)  { }

      SpPad sp;
      double dp;
      uint64_t i64;
    };
	
  private:

    std::vector<double> regs_;
    int lastWrittenReg_ = -1;    // Register accessed in most recent write.
    unsigned lastFpFlags_ = 0;
    double originalValue_ = 0;   // Original value of last written reg.
    unsigned flen_ = 64;         // Floating point register width.
    bool nanBox_ = true;
    std::unordered_map<std::string, FpRegNumber> nameToNumber_;
    std::vector<std::string> numberToAbiName_;
    std::vector<std::string> numberToName_;
  };


  inline
  float
  FpRegs::readSingle(unsigned i) const
  {
    FpUnion u{regs_.at(i)};
    if (not nanBox_)
      return u.sp.sp;

    // Check for proper nan-boxing. If not properly boxed, replace with NaN.
    if (~u.sp.pad != 0)
      return std::numeric_limits<float>::quiet_NaN();
    return u.sp.sp;
  }


  inline
  void
  FpRegs::writeSingle(unsigned i, float x)
  {
    FpUnion u{x};
    if (nanBox_)
      u.sp.pad = ~uint32_t(0);  // Nan box: Bit pattern for negative quiet NAN.
    writeDouble(i, u.dp);
  }
}
