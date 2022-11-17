GAS LISTING /tmp/ccUgdhPb.s 			page 1


   1              		.file	"sha256.c"
   2              		.option nopic
   3              		.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
   4              		.attribute unaligned_access, 0
   5              		.attribute stack_align, 16
   6              		.text
   7              	.Ltext0:
   8              		.cfi_sections	.debug_frame
   9              		.section	.rodata
  10              		.align	3
  11              		.type	k, @object
  12              		.size	k, 256
  13              	k:
  14 0000 982F8A42 		.word	1116352408
  15 0004 91443771 		.word	1899447441
  16 0008 CFFBC0B5 		.word	-1245643825
  17 000c A5DBB5E9 		.word	-373957723
  18 0010 5BC25639 		.word	961987163
  19 0014 F111F159 		.word	1508970993
  20 0018 A4823F92 		.word	-1841331548
  21 001c D55E1CAB 		.word	-1424204075
  22 0020 98AA07D8 		.word	-670586216
  23 0024 015B8312 		.word	310598401
  24 0028 BE853124 		.word	607225278
  25 002c C37D0C55 		.word	1426881987
  26 0030 745DBE72 		.word	1925078388
  27 0034 FEB1DE80 		.word	-2132889090
  28 0038 A706DC9B 		.word	-1680079193
  29 003c 74F19BC1 		.word	-1046744716
  30 0040 C1699BE4 		.word	-459576895
  31 0044 8647BEEF 		.word	-272742522
  32 0048 C69DC10F 		.word	264347078
  33 004c CCA10C24 		.word	604807628
  34 0050 6F2CE92D 		.word	770255983
  35 0054 AA84744A 		.word	1249150122
  36 0058 DCA9B05C 		.word	1555081692
  37 005c DA88F976 		.word	1996064986
  38 0060 52513E98 		.word	-1740746414
  39 0064 6DC631A8 		.word	-1473132947
  40 0068 C82703B0 		.word	-1341970488
  41 006c C77F59BF 		.word	-1084653625
  42 0070 F30BE0C6 		.word	-958395405
  43 0074 4791A7D5 		.word	-710438585
  44 0078 5163CA06 		.word	113926993
  45 007c 67292914 		.word	338241895
  46 0080 850AB727 		.word	666307205
  47 0084 38211B2E 		.word	773529912
  48 0088 FC6D2C4D 		.word	1294757372
  49 008c 130D3853 		.word	1396182291
  50 0090 54730A65 		.word	1695183700
  51 0094 BB0A6A76 		.word	1986661051
  52 0098 2EC9C281 		.word	-2117940946
  53 009c 852C7292 		.word	-1838011259
  54 00a0 A1E8BFA2 		.word	-1564481375
  55 00a4 4B661AA8 		.word	-1474664885
  56 00a8 708B4BC2 		.word	-1035236496
  57 00ac A3516CC7 		.word	-949202525
GAS LISTING /tmp/ccUgdhPb.s 			page 2


  58 00b0 19E892D1 		.word	-778901479
  59 00b4 240699D6 		.word	-694614492
  60 00b8 85350EF4 		.word	-200395387
  61 00bc 70A06A10 		.word	275423344
  62 00c0 16C1A419 		.word	430227734
  63 00c4 086C371E 		.word	506948616
  64 00c8 4C774827 		.word	659060556
  65 00cc B5BCB034 		.word	883997877
  66 00d0 B30C1C39 		.word	958139571
  67 00d4 4AAAD84E 		.word	1322822218
  68 00d8 4FCA9C5B 		.word	1537002063
  69 00dc F36F2E68 		.word	1747873779
  70 00e0 EE828F74 		.word	1955562222
  71 00e4 6F63A578 		.word	2024104815
  72 00e8 1478C884 		.word	-2067236844
  73 00ec 0802C78C 		.word	-1933114872
  74 00f0 FAFFBE90 		.word	-1866530822
  75 00f4 EB6C50A4 		.word	-1538233109
  76 00f8 F7A3F9BE 		.word	-1090935817
  77 00fc F27871C6 		.word	-965641998
  78              		.text
  79              		.align	1
  80              		.globl	sha256_transform
  81              		.type	sha256_transform, @function
  82              	sha256_transform:
  83              	.LFB4:
  84              		.file 1 "sha256.c"
   1:sha256.c      **** /*************************** HEADER FILES ***************************/
   2:sha256.c      **** #include <stddef.h>
   3:sha256.c      **** #include <stdlib.h>
   4:sha256.c      **** #include <memory.h>
   5:sha256.c      **** #include <stdio.h>
   6:sha256.c      **** 
   7:sha256.c      **** /**************************** DATA TYPES ****************************/
   8:sha256.c      **** typedef unsigned char BYTE;             // 8-bit byte
   9:sha256.c      **** typedef unsigned int  WORD;             // 32-bit word
  10:sha256.c      **** 
  11:sha256.c      **** typedef struct {
  12:sha256.c      **** 	BYTE data[64];
  13:sha256.c      **** 	WORD datalen;
  14:sha256.c      **** 	unsigned long long bitlen;
  15:sha256.c      **** 	WORD state[8];
  16:sha256.c      **** } SHA256_CTX;
  17:sha256.c      **** 
  18:sha256.c      **** 
  19:sha256.c      **** /****************************** MACROS ******************************/
  20:sha256.c      **** #define SHA256_BLOCK_SIZE 32            // SHA256 outputs a 32 byte digest
  21:sha256.c      **** #define INPUT_SIZE 256            		// SHA256 input 256 string
  22:sha256.c      **** 
  23:sha256.c      **** #define ROTLEFT(a,b) (((a) << (b)) | ((a) >> (32-(b))))
  24:sha256.c      **** #define ROTRIGHT(a,b) (((a) >> (b)) | ((a) << (32-(b))))
  25:sha256.c      **** #define NOTAND(a,b) (~(a) & (b))
  26:sha256.c      **** 
  27:sha256.c      **** #define CH(x,y,z) (((x) & (y)) ^ NOTAND(x,z))
  28:sha256.c      **** #define MAJ(x,y,z) (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))
  29:sha256.c      **** #define EP0(x) (ROTRIGHT(x,2) ^ ROTRIGHT(x,13) ^ ROTRIGHT(x,22))
  30:sha256.c      **** #define EP1(x) (ROTLEFT(x,7) ^ ROTLEFT(x,21) ^ ROTLEFT(x,26))
GAS LISTING /tmp/ccUgdhPb.s 			page 3


  31:sha256.c      **** #define SIG0(x) (ROTRIGHT(x,7) ^ ROTRIGHT(x,18) ^ ((x) >> 3))
  32:sha256.c      **** #define SIG1(x) (ROTLEFT(x,13) ^ ROTLEFT(x,15) ^ ((x) >> 10))
  33:sha256.c      **** 
  34:sha256.c      **** /**************************** VARIABLES *****************************/
  35:sha256.c      **** static const WORD k[64] = {
  36:sha256.c      **** 	0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,
  37:sha256.c      **** 	0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,
  38:sha256.c      **** 	0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,
  39:sha256.c      **** 	0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,
  40:sha256.c      **** 	0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,
  41:sha256.c      **** 	0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,
  42:sha256.c      **** 	0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,
  43:sha256.c      **** 	0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2
  44:sha256.c      **** };
  45:sha256.c      **** 
  46:sha256.c      **** /*********************** FUNCTION DEFINITIONS ***********************/
  47:sha256.c      **** void sha256_transform(SHA256_CTX *ctx, const BYTE data[])
  48:sha256.c      **** {
  85              		.loc 1 48 1
  86              		.cfi_startproc
  87 0000 4D71     		addi	sp,sp,-336
  88              		.cfi_def_cfa_offset 336
  89 0002 A2E6     		sd	s0,328(sp)
  90              		.cfi_offset 8, -8
  91 0004 800A     		addi	s0,sp,336
  92              		.cfi_def_cfa 8, 0
  93 0006 233CA4EA 		sd	a0,-328(s0)
  94 000a 2338B4EA 		sd	a1,-336(s0)
  49:sha256.c      **** 	WORD a, b, c, d, e, f, g, h, i, j, t1, t2, m[64];
  50:sha256.c      **** 
  51:sha256.c      **** 	for (i = 0, j = 0; i < 16; ++i, j += 4)
  95              		.loc 1 51 9
  96 000e 232604FC 		sw	zero,-52(s0)
  97              		.loc 1 51 16
  98 0012 232404FC 		sw	zero,-56(s0)
  99              		.loc 1 51 2
 100 0016 5DA0     		j	.L2
 101              	.L3:
  52:sha256.c      **** 		m[i] = (data[j] << 24) | (data[j + 1] << 16) | (data[j + 2] << 8) | (data[j + 3]);
 102              		.loc 1 52 15 discriminator 3
 103 0018 836784FC 		lwu	a5,-56(s0)
 104 001c 033704EB 		ld	a4,-336(s0)
 105 0020 BA97     		add	a5,a4,a5
 106 0022 83C70700 		lbu	a5,0(a5)
 107 0026 8127     		sext.w	a5,a5
 108              		.loc 1 52 19 discriminator 3
 109 0028 9B978701 		slliw	a5,a5,24
 110 002c 1B870700 		sext.w	a4,a5
 111              		.loc 1 52 36 discriminator 3
 112 0030 832784FC 		lw	a5,-56(s0)
 113 0034 8527     		addiw	a5,a5,1
 114 0036 8127     		sext.w	a5,a5
 115 0038 8217     		slli	a5,a5,32
 116 003a 8193     		srli	a5,a5,32
 117              		.loc 1 52 33 discriminator 3
 118 003c 833604EB 		ld	a3,-336(s0)
 119 0040 B697     		add	a5,a3,a5
GAS LISTING /tmp/ccUgdhPb.s 			page 4


 120 0042 83C70700 		lbu	a5,0(a5)
 121 0046 8127     		sext.w	a5,a5
 122              		.loc 1 52 41 discriminator 3
 123 0048 9B970701 		slliw	a5,a5,16
 124 004c 8127     		sext.w	a5,a5
 125              		.loc 1 52 26 discriminator 3
 126 004e D98F     		or	a5,a4,a5
 127 0050 1B870700 		sext.w	a4,a5
 128              		.loc 1 52 58 discriminator 3
 129 0054 832784FC 		lw	a5,-56(s0)
 130 0058 8927     		addiw	a5,a5,2
 131 005a 8127     		sext.w	a5,a5
 132 005c 8217     		slli	a5,a5,32
 133 005e 8193     		srli	a5,a5,32
 134              		.loc 1 52 55 discriminator 3
 135 0060 833604EB 		ld	a3,-336(s0)
 136 0064 B697     		add	a5,a3,a5
 137 0066 83C70700 		lbu	a5,0(a5)
 138 006a 8127     		sext.w	a5,a5
 139              		.loc 1 52 63 discriminator 3
 140 006c 9B978700 		slliw	a5,a5,8
 141 0070 8127     		sext.w	a5,a5
 142              		.loc 1 52 48 discriminator 3
 143 0072 D98F     		or	a5,a4,a5
 144 0074 1B870700 		sext.w	a4,a5
 145              		.loc 1 52 79 discriminator 3
 146 0078 832784FC 		lw	a5,-56(s0)
 147 007c 8D27     		addiw	a5,a5,3
 148 007e 8127     		sext.w	a5,a5
 149 0080 8217     		slli	a5,a5,32
 150 0082 8193     		srli	a5,a5,32
 151              		.loc 1 52 76 discriminator 3
 152 0084 833604EB 		ld	a3,-336(s0)
 153 0088 B697     		add	a5,a3,a5
 154 008a 83C70700 		lbu	a5,0(a5)
 155 008e 8127     		sext.w	a5,a5
 156              		.loc 1 52 69 discriminator 3
 157 0090 D98F     		or	a5,a4,a5
 158 0092 8127     		sext.w	a5,a5
 159 0094 1B870700 		sext.w	a4,a5
 160              		.loc 1 52 8 discriminator 3
 161 0098 8367C4FC 		lwu	a5,-52(s0)
 162 009c 8A07     		slli	a5,a5,2
 163 009e 930604FF 		addi	a3,s0,-16
 164 00a2 B697     		add	a5,a3,a5
 165 00a4 23A8E7EC 		sw	a4,-304(a5)
  51:sha256.c      **** 		m[i] = (data[j] << 24) | (data[j + 1] << 16) | (data[j + 2] << 8) | (data[j + 3]);
 166              		.loc 1 51 29 discriminator 3
 167 00a8 8327C4FC 		lw	a5,-52(s0)
 168 00ac 8527     		addiw	a5,a5,1
 169 00ae 2326F4FC 		sw	a5,-52(s0)
  51:sha256.c      **** 		m[i] = (data[j] << 24) | (data[j + 1] << 16) | (data[j + 2] << 8) | (data[j + 3]);
 170              		.loc 1 51 36 discriminator 3
 171 00b2 832784FC 		lw	a5,-56(s0)
 172 00b6 9127     		addiw	a5,a5,4
 173 00b8 2324F4FC 		sw	a5,-56(s0)
 174              	.L2:
GAS LISTING /tmp/ccUgdhPb.s 			page 5


  51:sha256.c      **** 		m[i] = (data[j] << 24) | (data[j + 1] << 16) | (data[j + 2] << 8) | (data[j + 3]);
 175              		.loc 1 51 2 discriminator 1
 176 00bc 8327C4FC 		lw	a5,-52(s0)
 177 00c0 1B870700 		sext.w	a4,a5
 178 00c4 BD47     		li	a5,15
 179 00c6 E3F9E7F4 		bleu	a4,a5,.L3
  53:sha256.c      **** 	for ( ; i < 64; ++i)
 180              		.loc 1 53 2
 181 00ca A1A2     		j	.L4
 182              	.L5:
  54:sha256.c      **** 		m[i] = SIG1(m[i - 2]) + m[i - 7] + SIG0(m[i - 15]) + m[i - 16];
 183              		.loc 1 54 10 discriminator 2
 184 00cc 8327C4FC 		lw	a5,-52(s0)
 185 00d0 F937     		addiw	a5,a5,-2
 186 00d2 8127     		sext.w	a5,a5
 187 00d4 8217     		slli	a5,a5,32
 188 00d6 8193     		srli	a5,a5,32
 189 00d8 8A07     		slli	a5,a5,2
 190 00da 130704FF 		addi	a4,s0,-16
 191 00de BA97     		add	a5,a4,a5
 192 00e0 83A707ED 		lw	a5,-304(a5)
 193 00e4 1B97D700 		slliw	a4,a5,13
 194 00e8 9BD73701 		srliw	a5,a5,19
 195 00ec D98F     		or	a5,a4,a5
 196 00ee 9B860700 		sext.w	a3,a5
 197 00f2 8327C4FC 		lw	a5,-52(s0)
 198 00f6 F937     		addiw	a5,a5,-2
 199 00f8 8127     		sext.w	a5,a5
 200 00fa 8217     		slli	a5,a5,32
 201 00fc 8193     		srli	a5,a5,32
 202 00fe 8A07     		slli	a5,a5,2
 203 0100 130704FF 		addi	a4,s0,-16
 204 0104 BA97     		add	a5,a4,a5
 205 0106 83A707ED 		lw	a5,-304(a5)
 206 010a 1B97F700 		slliw	a4,a5,15
 207 010e 9BD71701 		srliw	a5,a5,17
 208 0112 D98F     		or	a5,a4,a5
 209 0114 8127     		sext.w	a5,a5
 210 0116 3687     		mv	a4,a3
 211 0118 B98F     		xor	a5,a4,a5
 212 011a 1B870700 		sext.w	a4,a5
 213 011e 8327C4FC 		lw	a5,-52(s0)
 214 0122 F937     		addiw	a5,a5,-2
 215 0124 8127     		sext.w	a5,a5
 216 0126 8217     		slli	a5,a5,32
 217 0128 8193     		srli	a5,a5,32
 218 012a 8A07     		slli	a5,a5,2
 219 012c 930604FF 		addi	a3,s0,-16
 220 0130 B697     		add	a5,a3,a5
 221 0132 83A707ED 		lw	a5,-304(a5)
 222 0136 9BD7A700 		srliw	a5,a5,10
 223 013a 8127     		sext.w	a5,a5
 224 013c B98F     		xor	a5,a4,a5
 225 013e 1B870700 		sext.w	a4,a5
 226              		.loc 1 54 31 discriminator 2
 227 0142 8327C4FC 		lw	a5,-52(s0)
 228 0146 E537     		addiw	a5,a5,-7
GAS LISTING /tmp/ccUgdhPb.s 			page 6


 229 0148 8127     		sext.w	a5,a5
 230              		.loc 1 54 28 discriminator 2
 231 014a 8217     		slli	a5,a5,32
 232 014c 8193     		srli	a5,a5,32
 233 014e 8A07     		slli	a5,a5,2
 234 0150 930604FF 		addi	a3,s0,-16
 235 0154 B697     		add	a5,a3,a5
 236 0156 83A707ED 		lw	a5,-304(a5)
 237              		.loc 1 54 25 discriminator 2
 238 015a B99F     		addw	a5,a4,a5
 239 015c 1B870700 		sext.w	a4,a5
 240              		.loc 1 54 38 discriminator 2
 241 0160 8327C4FC 		lw	a5,-52(s0)
 242 0164 C537     		addiw	a5,a5,-15
 243 0166 8127     		sext.w	a5,a5
 244 0168 8217     		slli	a5,a5,32
 245 016a 8193     		srli	a5,a5,32
 246 016c 8A07     		slli	a5,a5,2
 247 016e 930604FF 		addi	a3,s0,-16
 248 0172 B697     		add	a5,a3,a5
 249 0174 83A707ED 		lw	a5,-304(a5)
 250 0178 9BD67700 		srliw	a3,a5,7
 251 017c 9B979701 		slliw	a5,a5,25
 252 0180 D58F     		or	a5,a3,a5
 253 0182 1B860700 		sext.w	a2,a5
 254 0186 8327C4FC 		lw	a5,-52(s0)
 255 018a C537     		addiw	a5,a5,-15
 256 018c 8127     		sext.w	a5,a5
 257 018e 8217     		slli	a5,a5,32
 258 0190 8193     		srli	a5,a5,32
 259 0192 8A07     		slli	a5,a5,2
 260 0194 930604FF 		addi	a3,s0,-16
 261 0198 B697     		add	a5,a3,a5
 262 019a 83A707ED 		lw	a5,-304(a5)
 263 019e 9B96E700 		slliw	a3,a5,14
 264 01a2 9BD72701 		srliw	a5,a5,18
 265 01a6 D58F     		or	a5,a3,a5
 266 01a8 8127     		sext.w	a5,a5
 267 01aa B286     		mv	a3,a2
 268 01ac B58F     		xor	a5,a3,a5
 269 01ae 9B860700 		sext.w	a3,a5
 270 01b2 8327C4FC 		lw	a5,-52(s0)
 271 01b6 C537     		addiw	a5,a5,-15
 272 01b8 8127     		sext.w	a5,a5
 273 01ba 8217     		slli	a5,a5,32
 274 01bc 8193     		srli	a5,a5,32
 275 01be 8A07     		slli	a5,a5,2
 276 01c0 130604FF 		addi	a2,s0,-16
 277 01c4 B297     		add	a5,a2,a5
 278 01c6 83A707ED 		lw	a5,-304(a5)
 279 01ca 9BD73700 		srliw	a5,a5,3
 280 01ce 8127     		sext.w	a5,a5
 281 01d0 B58F     		xor	a5,a3,a5
 282 01d2 8127     		sext.w	a5,a5
 283              		.loc 1 54 36 discriminator 2
 284 01d4 B99F     		addw	a5,a4,a5
 285 01d6 1B870700 		sext.w	a4,a5
GAS LISTING /tmp/ccUgdhPb.s 			page 7


 286              		.loc 1 54 60 discriminator 2
 287 01da 8327C4FC 		lw	a5,-52(s0)
 288 01de C137     		addiw	a5,a5,-16
 289 01e0 8127     		sext.w	a5,a5
 290              		.loc 1 54 57 discriminator 2
 291 01e2 8217     		slli	a5,a5,32
 292 01e4 8193     		srli	a5,a5,32
 293 01e6 8A07     		slli	a5,a5,2
 294 01e8 930604FF 		addi	a3,s0,-16
 295 01ec B697     		add	a5,a3,a5
 296 01ee 83A707ED 		lw	a5,-304(a5)
 297              		.loc 1 54 54 discriminator 2
 298 01f2 B99F     		addw	a5,a4,a5
 299 01f4 1B870700 		sext.w	a4,a5
 300              		.loc 1 54 8 discriminator 2
 301 01f8 8367C4FC 		lwu	a5,-52(s0)
 302 01fc 8A07     		slli	a5,a5,2
 303 01fe 930604FF 		addi	a3,s0,-16
 304 0202 B697     		add	a5,a3,a5
 305 0204 23A8E7EC 		sw	a4,-304(a5)
  53:sha256.c      **** 	for ( ; i < 64; ++i)
 306              		.loc 1 53 18 discriminator 2
 307 0208 8327C4FC 		lw	a5,-52(s0)
 308 020c 8527     		addiw	a5,a5,1
 309 020e 2326F4FC 		sw	a5,-52(s0)
 310              	.L4:
  53:sha256.c      **** 	for ( ; i < 64; ++i)
 311              		.loc 1 53 2 discriminator 1
 312 0212 8327C4FC 		lw	a5,-52(s0)
 313 0216 1B870700 		sext.w	a4,a5
 314 021a 9307F003 		li	a5,63
 315 021e E3F7E7EA 		bleu	a4,a5,.L5
  55:sha256.c      **** 
  56:sha256.c      **** 	a = ctx->state[0];
 316              		.loc 1 56 4
 317 0222 833784EB 		ld	a5,-328(s0)
 318 0226 BC4B     		lw	a5,80(a5)
 319 0228 2326F4FE 		sw	a5,-20(s0)
  57:sha256.c      **** 	b = ctx->state[1];
 320              		.loc 1 57 4
 321 022c 833784EB 		ld	a5,-328(s0)
 322 0230 FC4B     		lw	a5,84(a5)
 323 0232 2324F4FE 		sw	a5,-24(s0)
  58:sha256.c      **** 	c = ctx->state[2];
 324              		.loc 1 58 4
 325 0236 833784EB 		ld	a5,-328(s0)
 326 023a BC4F     		lw	a5,88(a5)
 327 023c 2322F4FE 		sw	a5,-28(s0)
  59:sha256.c      **** 	d = ctx->state[3];
 328              		.loc 1 59 4
 329 0240 833784EB 		ld	a5,-328(s0)
 330 0244 FC4F     		lw	a5,92(a5)
 331 0246 2320F4FE 		sw	a5,-32(s0)
  60:sha256.c      **** 	e = ctx->state[4];
 332              		.loc 1 60 4
 333 024a 833784EB 		ld	a5,-328(s0)
 334 024e BC53     		lw	a5,96(a5)
GAS LISTING /tmp/ccUgdhPb.s 			page 8


 335 0250 232EF4FC 		sw	a5,-36(s0)
  61:sha256.c      **** 	f = ctx->state[5];
 336              		.loc 1 61 4
 337 0254 833784EB 		ld	a5,-328(s0)
 338 0258 FC53     		lw	a5,100(a5)
 339 025a 232CF4FC 		sw	a5,-40(s0)
  62:sha256.c      **** 	g = ctx->state[6];
 340              		.loc 1 62 4
 341 025e 833784EB 		ld	a5,-328(s0)
 342 0262 BC57     		lw	a5,104(a5)
 343 0264 232AF4FC 		sw	a5,-44(s0)
  63:sha256.c      **** 	h = ctx->state[7];
 344              		.loc 1 63 4
 345 0268 833784EB 		ld	a5,-328(s0)
 346 026c FC57     		lw	a5,108(a5)
 347 026e 2328F4FC 		sw	a5,-48(s0)
  64:sha256.c      **** 
  65:sha256.c      **** 	for (i = 0; i < 64; ++i) {
 348              		.loc 1 65 9
 349 0272 232604FC 		sw	zero,-52(s0)
 350              		.loc 1 65 2
 351 0276 BDA2     		j	.L6
 352              	.L7:
  66:sha256.c      **** 		t1 = h + EP1(e) + CH(e,f,g) + k[i] + m[i];
 353              		.loc 1 66 12 discriminator 3
 354 0278 8327C4FD 		lw	a5,-36(s0)
 355 027c 1B977700 		slliw	a4,a5,7
 356 0280 9BD79701 		srliw	a5,a5,25
 357 0284 D98F     		or	a5,a4,a5
 358 0286 9B860700 		sext.w	a3,a5
 359 028a 8327C4FD 		lw	a5,-36(s0)
 360 028e 1BD7B700 		srliw	a4,a5,11
 361 0292 9B975701 		slliw	a5,a5,21
 362 0296 D98F     		or	a5,a4,a5
 363 0298 8127     		sext.w	a5,a5
 364 029a 3687     		mv	a4,a3
 365 029c B98F     		xor	a5,a4,a5
 366 029e 9B860700 		sext.w	a3,a5
 367 02a2 8327C4FD 		lw	a5,-36(s0)
 368 02a6 1BD76700 		srliw	a4,a5,6
 369 02aa 9B97A701 		slliw	a5,a5,26
 370 02ae D98F     		or	a5,a4,a5
 371 02b0 8127     		sext.w	a5,a5
 372 02b2 3687     		mv	a4,a3
 373 02b4 B98F     		xor	a5,a4,a5
 374 02b6 8127     		sext.w	a5,a5
 375              		.loc 1 66 10 discriminator 3
 376 02b8 032704FD 		lw	a4,-48(s0)
 377 02bc B99F     		addw	a5,a4,a5
 378 02be 1B870700 		sext.w	a4,a5
 379              		.loc 1 66 21 discriminator 3
 380 02c2 8326C4FD 		lw	a3,-36(s0)
 381 02c6 832784FD 		lw	a5,-40(s0)
 382 02ca F58F     		and	a5,a3,a5
 383 02cc 9B860700 		sext.w	a3,a5
 384 02d0 8327C4FD 		lw	a5,-36(s0)
 385 02d4 93C7F7FF 		not	a5,a5
GAS LISTING /tmp/ccUgdhPb.s 			page 9


 386 02d8 1B860700 		sext.w	a2,a5
 387 02dc 832744FD 		lw	a5,-44(s0)
 388 02e0 F18F     		and	a5,a5,a2
 389 02e2 8127     		sext.w	a5,a5
 390 02e4 B58F     		xor	a5,a3,a5
 391 02e6 8127     		sext.w	a5,a5
 392              		.loc 1 66 19 discriminator 3
 393 02e8 B99F     		addw	a5,a4,a5
 394 02ea 1B870700 		sext.w	a4,a5
 395              		.loc 1 66 34 discriminator 3
 396 02ee B7070000 		lui	a5,%hi(k)
 397 02f2 93860700 		addi	a3,a5,%lo(k)
 398 02f6 8367C4FC 		lwu	a5,-52(s0)
 399 02fa 8A07     		slli	a5,a5,2
 400 02fc B697     		add	a5,a3,a5
 401 02fe 9C43     		lw	a5,0(a5)
 402              		.loc 1 66 31 discriminator 3
 403 0300 B99F     		addw	a5,a4,a5
 404 0302 1B870700 		sext.w	a4,a5
 405              		.loc 1 66 41 discriminator 3
 406 0306 8367C4FC 		lwu	a5,-52(s0)
 407 030a 8A07     		slli	a5,a5,2
 408 030c 930604FF 		addi	a3,s0,-16
 409 0310 B697     		add	a5,a3,a5
 410 0312 83A707ED 		lw	a5,-304(a5)
 411              		.loc 1 66 6 discriminator 3
 412 0316 B99F     		addw	a5,a4,a5
 413 0318 2322F4FC 		sw	a5,-60(s0)
  67:sha256.c      **** 		t2 = EP0(a) + MAJ(a,b,c);
 414              		.loc 1 67 8 discriminator 3
 415 031c 8327C4FE 		lw	a5,-20(s0)
 416 0320 1BD72700 		srliw	a4,a5,2
 417 0324 9B97E701 		slliw	a5,a5,30
 418 0328 D98F     		or	a5,a4,a5
 419 032a 9B860700 		sext.w	a3,a5
 420 032e 8327C4FE 		lw	a5,-20(s0)
 421 0332 1BD7D700 		srliw	a4,a5,13
 422 0336 9B973701 		slliw	a5,a5,19
 423 033a D98F     		or	a5,a4,a5
 424 033c 8127     		sext.w	a5,a5
 425 033e 3687     		mv	a4,a3
 426 0340 B98F     		xor	a5,a4,a5
 427 0342 9B860700 		sext.w	a3,a5
 428 0346 8327C4FE 		lw	a5,-20(s0)
 429 034a 1B97A700 		slliw	a4,a5,10
 430 034e 9BD76701 		srliw	a5,a5,22
 431 0352 D98F     		or	a5,a4,a5
 432 0354 8127     		sext.w	a5,a5
 433 0356 3687     		mv	a4,a3
 434 0358 B98F     		xor	a5,a4,a5
 435 035a 1B870700 		sext.w	a4,a5
 436              		.loc 1 67 17 discriminator 3
 437 035e 832684FE 		lw	a3,-24(s0)
 438 0362 832744FE 		lw	a5,-28(s0)
 439 0366 B58F     		xor	a5,a3,a5
 440 0368 9B860700 		sext.w	a3,a5
 441 036c 8327C4FE 		lw	a5,-20(s0)
GAS LISTING /tmp/ccUgdhPb.s 			page 10


 442 0370 F58F     		and	a5,a5,a3
 443 0372 1B860700 		sext.w	a2,a5
 444 0376 832684FE 		lw	a3,-24(s0)
 445 037a 832744FE 		lw	a5,-28(s0)
 446 037e F58F     		and	a5,a3,a5
 447 0380 8127     		sext.w	a5,a5
 448 0382 B286     		mv	a3,a2
 449 0384 B58F     		xor	a5,a3,a5
 450 0386 8127     		sext.w	a5,a5
 451              		.loc 1 67 6 discriminator 3
 452 0388 B99F     		addw	a5,a4,a5
 453 038a 2320F4FC 		sw	a5,-64(s0)
  68:sha256.c      **** 		h = g;
 454              		.loc 1 68 5 discriminator 3
 455 038e 832744FD 		lw	a5,-44(s0)
 456 0392 2328F4FC 		sw	a5,-48(s0)
  69:sha256.c      **** 		g = f;
 457              		.loc 1 69 5 discriminator 3
 458 0396 832784FD 		lw	a5,-40(s0)
 459 039a 232AF4FC 		sw	a5,-44(s0)
  70:sha256.c      **** 		f = e;
 460              		.loc 1 70 5 discriminator 3
 461 039e 8327C4FD 		lw	a5,-36(s0)
 462 03a2 232CF4FC 		sw	a5,-40(s0)
  71:sha256.c      **** 		e = d + t1;
 463              		.loc 1 71 5 discriminator 3
 464 03a6 032704FE 		lw	a4,-32(s0)
 465 03aa 832744FC 		lw	a5,-60(s0)
 466 03ae B99F     		addw	a5,a4,a5
 467 03b0 232EF4FC 		sw	a5,-36(s0)
  72:sha256.c      **** 		d = c;
 468              		.loc 1 72 5 discriminator 3
 469 03b4 832744FE 		lw	a5,-28(s0)
 470 03b8 2320F4FE 		sw	a5,-32(s0)
  73:sha256.c      **** 		c = b;
 471              		.loc 1 73 5 discriminator 3
 472 03bc 832784FE 		lw	a5,-24(s0)
 473 03c0 2322F4FE 		sw	a5,-28(s0)
  74:sha256.c      **** 		b = a;
 474              		.loc 1 74 5 discriminator 3
 475 03c4 8327C4FE 		lw	a5,-20(s0)
 476 03c8 2324F4FE 		sw	a5,-24(s0)
  75:sha256.c      **** 		a = t1 + t2;
 477              		.loc 1 75 5 discriminator 3
 478 03cc 032744FC 		lw	a4,-60(s0)
 479 03d0 832704FC 		lw	a5,-64(s0)
 480 03d4 B99F     		addw	a5,a4,a5
 481 03d6 2326F4FE 		sw	a5,-20(s0)
  65:sha256.c      **** 		t1 = h + EP1(e) + CH(e,f,g) + k[i] + m[i];
 482              		.loc 1 65 22 discriminator 3
 483 03da 8327C4FC 		lw	a5,-52(s0)
 484 03de 8527     		addiw	a5,a5,1
 485 03e0 2326F4FC 		sw	a5,-52(s0)
 486              	.L6:
  65:sha256.c      **** 		t1 = h + EP1(e) + CH(e,f,g) + k[i] + m[i];
 487              		.loc 1 65 2 discriminator 1
 488 03e4 8327C4FC 		lw	a5,-52(s0)
GAS LISTING /tmp/ccUgdhPb.s 			page 11


 489 03e8 1B870700 		sext.w	a4,a5
 490 03ec 9307F003 		li	a5,63
 491 03f0 E3F4E7E8 		bleu	a4,a5,.L7
  76:sha256.c      **** 	}
  77:sha256.c      **** 
  78:sha256.c      **** 	ctx->state[0] += a;
 492              		.loc 1 78 16
 493 03f4 833784EB 		ld	a5,-328(s0)
 494 03f8 BC4B     		lw	a5,80(a5)
 495 03fa 0327C4FE 		lw	a4,-20(s0)
 496 03fe B99F     		addw	a5,a4,a5
 497 0400 1B870700 		sext.w	a4,a5
 498 0404 833784EB 		ld	a5,-328(s0)
 499 0408 B8CB     		sw	a4,80(a5)
  79:sha256.c      **** 	ctx->state[1] += b;
 500              		.loc 1 79 16
 501 040a 833784EB 		ld	a5,-328(s0)
 502 040e FC4B     		lw	a5,84(a5)
 503 0410 032784FE 		lw	a4,-24(s0)
 504 0414 B99F     		addw	a5,a4,a5
 505 0416 1B870700 		sext.w	a4,a5
 506 041a 833784EB 		ld	a5,-328(s0)
 507 041e F8CB     		sw	a4,84(a5)
  80:sha256.c      **** 	ctx->state[2] += c;
 508              		.loc 1 80 16
 509 0420 833784EB 		ld	a5,-328(s0)
 510 0424 BC4F     		lw	a5,88(a5)
 511 0426 032744FE 		lw	a4,-28(s0)
 512 042a B99F     		addw	a5,a4,a5
 513 042c 1B870700 		sext.w	a4,a5
 514 0430 833784EB 		ld	a5,-328(s0)
 515 0434 B8CF     		sw	a4,88(a5)
  81:sha256.c      **** 	ctx->state[3] += d;
 516              		.loc 1 81 16
 517 0436 833784EB 		ld	a5,-328(s0)
 518 043a FC4F     		lw	a5,92(a5)
 519 043c 032704FE 		lw	a4,-32(s0)
 520 0440 B99F     		addw	a5,a4,a5
 521 0442 1B870700 		sext.w	a4,a5
 522 0446 833784EB 		ld	a5,-328(s0)
 523 044a F8CF     		sw	a4,92(a5)
  82:sha256.c      **** 	ctx->state[4] += e;
 524              		.loc 1 82 16
 525 044c 833784EB 		ld	a5,-328(s0)
 526 0450 BC53     		lw	a5,96(a5)
 527 0452 0327C4FD 		lw	a4,-36(s0)
 528 0456 B99F     		addw	a5,a4,a5
 529 0458 1B870700 		sext.w	a4,a5
 530 045c 833784EB 		ld	a5,-328(s0)
 531 0460 B8D3     		sw	a4,96(a5)
  83:sha256.c      **** 	ctx->state[5] += f;
 532              		.loc 1 83 16
 533 0462 833784EB 		ld	a5,-328(s0)
 534 0466 FC53     		lw	a5,100(a5)
 535 0468 032784FD 		lw	a4,-40(s0)
 536 046c B99F     		addw	a5,a4,a5
 537 046e 1B870700 		sext.w	a4,a5
GAS LISTING /tmp/ccUgdhPb.s 			page 12


 538 0472 833784EB 		ld	a5,-328(s0)
 539 0476 F8D3     		sw	a4,100(a5)
  84:sha256.c      **** 	ctx->state[6] += g;
 540              		.loc 1 84 16
 541 0478 833784EB 		ld	a5,-328(s0)
 542 047c BC57     		lw	a5,104(a5)
 543 047e 032744FD 		lw	a4,-44(s0)
 544 0482 B99F     		addw	a5,a4,a5
 545 0484 1B870700 		sext.w	a4,a5
 546 0488 833784EB 		ld	a5,-328(s0)
 547 048c B8D7     		sw	a4,104(a5)
  85:sha256.c      **** 	ctx->state[7] += h;
 548              		.loc 1 85 16
 549 048e 833784EB 		ld	a5,-328(s0)
 550 0492 FC57     		lw	a5,108(a5)
 551 0494 032704FD 		lw	a4,-48(s0)
 552 0498 B99F     		addw	a5,a4,a5
 553 049a 1B870700 		sext.w	a4,a5
 554 049e 833784EB 		ld	a5,-328(s0)
 555 04a2 F8D7     		sw	a4,108(a5)
  86:sha256.c      **** }
 556              		.loc 1 86 1
 557 04a4 0100     		nop
 558 04a6 3664     		ld	s0,328(sp)
 559              		.cfi_restore 8
 560              		.cfi_def_cfa 2, 336
 561 04a8 7161     		addi	sp,sp,336
 562              		.cfi_def_cfa_offset 0
 563 04aa 8280     		jr	ra
 564              		.cfi_endproc
 565              	.LFE4:
 566              		.size	sha256_transform, .-sha256_transform
 567              		.align	1
 568              		.globl	sha256_init
 569              		.type	sha256_init, @function
 570              	sha256_init:
 571              	.LFB5:
  87:sha256.c      **** 
  88:sha256.c      **** void sha256_init(SHA256_CTX *ctx)
  89:sha256.c      **** {
 572              		.loc 1 89 1
 573              		.cfi_startproc
 574 04ac 0111     		addi	sp,sp,-32
 575              		.cfi_def_cfa_offset 32
 576 04ae 22EC     		sd	s0,24(sp)
 577              		.cfi_offset 8, -8
 578 04b0 0010     		addi	s0,sp,32
 579              		.cfi_def_cfa 8, 0
 580 04b2 2334A4FE 		sd	a0,-24(s0)
  90:sha256.c      **** 	ctx->datalen = 0;
 581              		.loc 1 90 15
 582 04b6 833784FE 		ld	a5,-24(s0)
 583 04ba 23A00704 		sw	zero,64(a5)
  91:sha256.c      **** 	ctx->bitlen = 0;
 584              		.loc 1 91 14
 585 04be 833784FE 		ld	a5,-24(s0)
 586 04c2 23B40704 		sd	zero,72(a5)
GAS LISTING /tmp/ccUgdhPb.s 			page 13


  92:sha256.c      **** 	ctx->state[0] = 0x6a09e667;
 587              		.loc 1 92 16
 588 04c6 833784FE 		ld	a5,-24(s0)
 589 04ca 37E7096A 		li	a4,1779032064
 590 04ce 13077766 		addi	a4,a4,1639
 591 04d2 B8CB     		sw	a4,80(a5)
  93:sha256.c      **** 	ctx->state[1] = 0xbb67ae85;
 592              		.loc 1 93 16
 593 04d4 833784FE 		ld	a5,-24(s0)
 594 04d8 37B767BB 		li	a4,-1150832640
 595 04dc 130757E8 		addi	a4,a4,-379
 596 04e0 F8CB     		sw	a4,84(a5)
  94:sha256.c      **** 	ctx->state[2] = 0x3c6ef372;
 597              		.loc 1 94 16
 598 04e2 833784FE 		ld	a5,-24(s0)
 599 04e6 37F76E3C 		li	a4,1013903360
 600 04ea 13072737 		addi	a4,a4,882
 601 04ee B8CF     		sw	a4,88(a5)
  95:sha256.c      **** 	ctx->state[3] = 0xa54ff53a;
 602              		.loc 1 95 16
 603 04f0 833784FE 		ld	a5,-24(s0)
 604 04f4 37F74FA5 		li	a4,-1521487872
 605 04f8 1307A753 		addi	a4,a4,1338
 606 04fc F8CF     		sw	a4,92(a5)
  96:sha256.c      **** 	ctx->state[4] = 0x510e527f;
 607              		.loc 1 96 16
 608 04fe 833784FE 		ld	a5,-24(s0)
 609 0502 37570E51 		li	a4,1359892480
 610 0506 1307F727 		addi	a4,a4,639
 611 050a B8D3     		sw	a4,96(a5)
  97:sha256.c      **** 	ctx->state[5] = 0x9b05688c;
 612              		.loc 1 97 16
 613 050c 833784FE 		ld	a5,-24(s0)
 614 0510 3777059B 		li	a4,-1694142464
 615 0514 1307C788 		addi	a4,a4,-1908
 616 0518 F8D3     		sw	a4,100(a5)
  98:sha256.c      **** 	ctx->state[6] = 0x1f83d9ab;
 617              		.loc 1 98 16
 618 051a 833784FE 		ld	a5,-24(s0)
 619 051e 37E7831F 		li	a4,528736256
 620 0522 1307B79A 		addi	a4,a4,-1621
 621 0526 B8D7     		sw	a4,104(a5)
  99:sha256.c      **** 	ctx->state[7] = 0x5be0cd19;
 622              		.loc 1 99 16
 623 0528 833784FE 		ld	a5,-24(s0)
 624 052c 37D7E05B 		li	a4,1541459968
 625 0530 130797D1 		addi	a4,a4,-743
 626 0534 F8D7     		sw	a4,108(a5)
 100:sha256.c      **** }
 627              		.loc 1 100 1
 628 0536 0100     		nop
 629 0538 6264     		ld	s0,24(sp)
 630              		.cfi_restore 8
 631              		.cfi_def_cfa 2, 32
 632 053a 0561     		addi	sp,sp,32
 633              		.cfi_def_cfa_offset 0
 634 053c 8280     		jr	ra
GAS LISTING /tmp/ccUgdhPb.s 			page 14


 635              		.cfi_endproc
 636              	.LFE5:
 637              		.size	sha256_init, .-sha256_init
 638              		.align	1
 639              		.globl	sha256_update
 640              		.type	sha256_update, @function
 641              	sha256_update:
 642              	.LFB6:
 101:sha256.c      **** 
 102:sha256.c      **** void sha256_update(SHA256_CTX *ctx, const BYTE data[], size_t len)
 103:sha256.c      **** {
 643              		.loc 1 103 1
 644              		.cfi_startproc
 645 053e 3971     		addi	sp,sp,-64
 646              		.cfi_def_cfa_offset 64
 647 0540 06FC     		sd	ra,56(sp)
 648 0542 22F8     		sd	s0,48(sp)
 649              		.cfi_offset 1, -8
 650              		.cfi_offset 8, -16
 651 0544 8000     		addi	s0,sp,64
 652              		.cfi_def_cfa 8, 0
 653 0546 233CA4FC 		sd	a0,-40(s0)
 654 054a 2338B4FC 		sd	a1,-48(s0)
 655 054e 2334C4FC 		sd	a2,-56(s0)
 104:sha256.c      **** 	WORD i;
 105:sha256.c      **** 
 106:sha256.c      **** 	for (i = 0; i < len; ++i) {
 656              		.loc 1 106 9
 657 0552 232604FE 		sw	zero,-20(s0)
 658              		.loc 1 106 2
 659 0556 B5A8     		j	.L10
 660              	.L12:
 107:sha256.c      **** 		ctx->data[ctx->datalen] = data[i];
 661              		.loc 1 107 33
 662 0558 8367C4FE 		lwu	a5,-20(s0)
 663 055c 033704FD 		ld	a4,-48(s0)
 664 0560 BA97     		add	a5,a4,a5
 665              		.loc 1 107 16
 666 0562 033784FD 		ld	a4,-40(s0)
 667 0566 3043     		lw	a2,64(a4)
 668              		.loc 1 107 33
 669 0568 03C70700 		lbu	a4,0(a5)
 670              		.loc 1 107 27
 671 056c 833684FD 		ld	a3,-40(s0)
 672 0570 93170602 		slli	a5,a2,32
 673 0574 8193     		srli	a5,a5,32
 674 0576 B697     		add	a5,a3,a5
 675 0578 2380E700 		sb	a4,0(a5)
 108:sha256.c      **** 		ctx->datalen++;
 676              		.loc 1 108 6
 677 057c 833784FD 		ld	a5,-40(s0)
 678 0580 BC43     		lw	a5,64(a5)
 679              		.loc 1 108 15
 680 0582 8527     		addiw	a5,a5,1
 681 0584 1B870700 		sext.w	a4,a5
 682 0588 833784FD 		ld	a5,-40(s0)
 683 058c B8C3     		sw	a4,64(a5)
GAS LISTING /tmp/ccUgdhPb.s 			page 15


 109:sha256.c      **** 		if (ctx->datalen == 64) {
 684              		.loc 1 109 10
 685 058e 833784FD 		ld	a5,-40(s0)
 686 0592 BC43     		lw	a5,64(a5)
 687              		.loc 1 109 6
 688 0594 3E87     		mv	a4,a5
 689 0596 93070004 		li	a5,64
 690 059a 6317F702 		bne	a4,a5,.L11
 110:sha256.c      **** 			sha256_transform(ctx, ctx->data);
 691              		.loc 1 110 29
 692 059e 833784FD 		ld	a5,-40(s0)
 693              		.loc 1 110 4
 694 05a2 BE85     		mv	a1,a5
 695 05a4 033584FD 		ld	a0,-40(s0)
 696 05a8 97000000 		call	sha256_transform
 696      E7800000 
 111:sha256.c      **** 			ctx->bitlen += 512;
 697              		.loc 1 111 16
 698 05b0 833784FD 		ld	a5,-40(s0)
 699 05b4 BC67     		ld	a5,72(a5)
 700 05b6 13870720 		addi	a4,a5,512
 701 05ba 833784FD 		ld	a5,-40(s0)
 702 05be B8E7     		sd	a4,72(a5)
 112:sha256.c      **** 			ctx->datalen = 0;
 703              		.loc 1 112 17
 704 05c0 833784FD 		ld	a5,-40(s0)
 705 05c4 23A00704 		sw	zero,64(a5)
 706              	.L11:
 106:sha256.c      **** 		ctx->data[ctx->datalen] = data[i];
 707              		.loc 1 106 23 discriminator 2
 708 05c8 8327C4FE 		lw	a5,-20(s0)
 709 05cc 8527     		addiw	a5,a5,1
 710 05ce 2326F4FE 		sw	a5,-20(s0)
 711              	.L10:
 106:sha256.c      **** 		ctx->data[ctx->datalen] = data[i];
 712              		.loc 1 106 16 discriminator 1
 713 05d2 8367C4FE 		lwu	a5,-20(s0)
 106:sha256.c      **** 		ctx->data[ctx->datalen] = data[i];
 714              		.loc 1 106 2 discriminator 1
 715 05d6 033784FC 		ld	a4,-56(s0)
 716 05da E3EFE7F6 		bgtu	a4,a5,.L12
 113:sha256.c      **** 		}
 114:sha256.c      **** 	}
 115:sha256.c      **** }
 717              		.loc 1 115 1
 718 05de 0100     		nop
 719 05e0 0100     		nop
 720 05e2 E270     		ld	ra,56(sp)
 721              		.cfi_restore 1
 722 05e4 4274     		ld	s0,48(sp)
 723              		.cfi_restore 8
 724              		.cfi_def_cfa 2, 64
 725 05e6 2161     		addi	sp,sp,64
 726              		.cfi_def_cfa_offset 0
 727 05e8 8280     		jr	ra
 728              		.cfi_endproc
 729              	.LFE6:
GAS LISTING /tmp/ccUgdhPb.s 			page 16


 730              		.size	sha256_update, .-sha256_update
 731              		.align	1
 732              		.globl	sha256_final
 733              		.type	sha256_final, @function
 734              	sha256_final:
 735              	.LFB7:
 116:sha256.c      **** 
 117:sha256.c      **** void sha256_final(SHA256_CTX *ctx, BYTE hash[])
 118:sha256.c      **** {
 736              		.loc 1 118 1
 737              		.cfi_startproc
 738 05ea 7971     		addi	sp,sp,-48
 739              		.cfi_def_cfa_offset 48
 740 05ec 06F4     		sd	ra,40(sp)
 741 05ee 22F0     		sd	s0,32(sp)
 742              		.cfi_offset 1, -8
 743              		.cfi_offset 8, -16
 744 05f0 0018     		addi	s0,sp,48
 745              		.cfi_def_cfa 8, 0
 746 05f2 233CA4FC 		sd	a0,-40(s0)
 747 05f6 2338B4FC 		sd	a1,-48(s0)
 119:sha256.c      **** 	WORD i;
 120:sha256.c      **** 
 121:sha256.c      **** 	i = ctx->datalen;
 748              		.loc 1 121 4
 749 05fa 833784FD 		ld	a5,-40(s0)
 750 05fe BC43     		lw	a5,64(a5)
 751 0600 2326F4FE 		sw	a5,-20(s0)
 122:sha256.c      **** 
 123:sha256.c      **** 	// Pad whatever data is left in the buffer.
 124:sha256.c      **** 	if (ctx->datalen < 56) {
 752              		.loc 1 124 9
 753 0604 833784FD 		ld	a5,-40(s0)
 754 0608 BC43     		lw	a5,64(a5)
 755              		.loc 1 124 5
 756 060a 3E87     		mv	a4,a5
 757 060c 93077003 		li	a5,55
 758 0610 63E8E704 		bgtu	a4,a5,.L14
 125:sha256.c      **** 		ctx->data[i++] = 0x80;
 759              		.loc 1 125 14
 760 0614 8327C4FE 		lw	a5,-20(s0)
 761 0618 1B871700 		addiw	a4,a5,1
 762 061c 2326E4FE 		sw	a4,-20(s0)
 763              		.loc 1 125 18
 764 0620 033784FD 		ld	a4,-40(s0)
 765 0624 8217     		slli	a5,a5,32
 766 0626 8193     		srli	a5,a5,32
 767 0628 BA97     		add	a5,a4,a5
 768 062a 130700F8 		li	a4,-128
 769 062e 2380E700 		sb	a4,0(a5)
 126:sha256.c      **** 		while (i < 56)
 770              		.loc 1 126 9
 771 0632 31A8     		j	.L15
 772              	.L16:
 127:sha256.c      **** 			ctx->data[i++] = 0x00;
 773              		.loc 1 127 15
 774 0634 8327C4FE 		lw	a5,-20(s0)
GAS LISTING /tmp/ccUgdhPb.s 			page 17


 775 0638 1B871700 		addiw	a4,a5,1
 776 063c 2326E4FE 		sw	a4,-20(s0)
 777              		.loc 1 127 19
 778 0640 033784FD 		ld	a4,-40(s0)
 779 0644 8217     		slli	a5,a5,32
 780 0646 8193     		srli	a5,a5,32
 781 0648 BA97     		add	a5,a4,a5
 782 064a 23800700 		sb	zero,0(a5)
 783              	.L15:
 126:sha256.c      **** 		while (i < 56)
 784              		.loc 1 126 9
 785 064e 8327C4FE 		lw	a5,-20(s0)
 786 0652 1B870700 		sext.w	a4,a5
 787 0656 93077003 		li	a5,55
 788 065a E3FDE7FC 		bleu	a4,a5,.L16
 789 065e 8DA8     		j	.L17
 790              	.L14:
 128:sha256.c      **** 	}
 129:sha256.c      **** 	else {
 130:sha256.c      **** 		ctx->data[i++] = 0x80;
 791              		.loc 1 130 14
 792 0660 8327C4FE 		lw	a5,-20(s0)
 793 0664 1B871700 		addiw	a4,a5,1
 794 0668 2326E4FE 		sw	a4,-20(s0)
 795              		.loc 1 130 18
 796 066c 033784FD 		ld	a4,-40(s0)
 797 0670 8217     		slli	a5,a5,32
 798 0672 8193     		srli	a5,a5,32
 799 0674 BA97     		add	a5,a4,a5
 800 0676 130700F8 		li	a4,-128
 801 067a 2380E700 		sb	a4,0(a5)
 131:sha256.c      **** 		while (i < 64)
 802              		.loc 1 131 9
 803 067e 31A8     		j	.L18
 804              	.L19:
 132:sha256.c      **** 			ctx->data[i++] = 0x00;
 805              		.loc 1 132 15
 806 0680 8327C4FE 		lw	a5,-20(s0)
 807 0684 1B871700 		addiw	a4,a5,1
 808 0688 2326E4FE 		sw	a4,-20(s0)
 809              		.loc 1 132 19
 810 068c 033784FD 		ld	a4,-40(s0)
 811 0690 8217     		slli	a5,a5,32
 812 0692 8193     		srli	a5,a5,32
 813 0694 BA97     		add	a5,a4,a5
 814 0696 23800700 		sb	zero,0(a5)
 815              	.L18:
 131:sha256.c      **** 		while (i < 64)
 816              		.loc 1 131 9
 817 069a 8327C4FE 		lw	a5,-20(s0)
 818 069e 1B870700 		sext.w	a4,a5
 819 06a2 9307F003 		li	a5,63
 820 06a6 E3FDE7FC 		bleu	a4,a5,.L19
 133:sha256.c      **** 		sha256_transform(ctx, ctx->data);
 821              		.loc 1 133 28
 822 06aa 833784FD 		ld	a5,-40(s0)
 823              		.loc 1 133 3
GAS LISTING /tmp/ccUgdhPb.s 			page 18


 824 06ae BE85     		mv	a1,a5
 825 06b0 033584FD 		ld	a0,-40(s0)
 826 06b4 97000000 		call	sha256_transform
 826      E7800000 
 134:sha256.c      **** 		memset(ctx->data, 0, 56);
 827              		.loc 1 134 13
 828 06bc 833784FD 		ld	a5,-40(s0)
 829              		.loc 1 134 3
 830 06c0 13068003 		li	a2,56
 831 06c4 8145     		li	a1,0
 832 06c6 3E85     		mv	a0,a5
 833 06c8 97000000 		call	memset
 833      E7800000 
 834              	.L17:
 135:sha256.c      **** 	}
 136:sha256.c      **** 
 137:sha256.c      **** 	// Append to the padding the total message's length in bits and transform.
 138:sha256.c      **** 	ctx->bitlen += ctx->datalen * 8;
 835              		.loc 1 138 14
 836 06d0 833784FD 		ld	a5,-40(s0)
 837 06d4 B867     		ld	a4,72(a5)
 838              		.loc 1 138 20
 839 06d6 833784FD 		ld	a5,-40(s0)
 840 06da BC43     		lw	a5,64(a5)
 841              		.loc 1 138 30
 842 06dc 9B973700 		slliw	a5,a5,3
 843 06e0 8127     		sext.w	a5,a5
 844 06e2 8217     		slli	a5,a5,32
 845 06e4 8193     		srli	a5,a5,32
 846              		.loc 1 138 14
 847 06e6 3E97     		add	a4,a4,a5
 848 06e8 833784FD 		ld	a5,-40(s0)
 849 06ec B8E7     		sd	a4,72(a5)
 139:sha256.c      **** 	ctx->data[63] = ctx->bitlen;
 850              		.loc 1 139 21
 851 06ee 833784FD 		ld	a5,-40(s0)
 852 06f2 BC67     		ld	a5,72(a5)
 853              		.loc 1 139 16
 854 06f4 13F7F70F 		andi	a4,a5,0xff
 855 06f8 833784FD 		ld	a5,-40(s0)
 856 06fc A38FE702 		sb	a4,63(a5)
 140:sha256.c      **** 	ctx->data[62] = ctx->bitlen >> 8;
 857              		.loc 1 140 21
 858 0700 833784FD 		ld	a5,-40(s0)
 859 0704 BC67     		ld	a5,72(a5)
 860              		.loc 1 140 30
 861 0706 A183     		srli	a5,a5,8
 862              		.loc 1 140 16
 863 0708 13F7F70F 		andi	a4,a5,0xff
 864 070c 833784FD 		ld	a5,-40(s0)
 865 0710 238FE702 		sb	a4,62(a5)
 141:sha256.c      **** 	ctx->data[61] = ctx->bitlen >> 16;
 866              		.loc 1 141 21
 867 0714 833784FD 		ld	a5,-40(s0)
 868 0718 BC67     		ld	a5,72(a5)
 869              		.loc 1 141 30
 870 071a C183     		srli	a5,a5,16
GAS LISTING /tmp/ccUgdhPb.s 			page 19


 871              		.loc 1 141 16
 872 071c 13F7F70F 		andi	a4,a5,0xff
 873 0720 833784FD 		ld	a5,-40(s0)
 874 0724 A38EE702 		sb	a4,61(a5)
 142:sha256.c      **** 	ctx->data[60] = ctx->bitlen >> 24;
 875              		.loc 1 142 21
 876 0728 833784FD 		ld	a5,-40(s0)
 877 072c BC67     		ld	a5,72(a5)
 878              		.loc 1 142 30
 879 072e E183     		srli	a5,a5,24
 880              		.loc 1 142 16
 881 0730 13F7F70F 		andi	a4,a5,0xff
 882 0734 833784FD 		ld	a5,-40(s0)
 883 0738 238EE702 		sb	a4,60(a5)
 143:sha256.c      **** 	ctx->data[59] = ctx->bitlen >> 32;
 884              		.loc 1 143 21
 885 073c 833784FD 		ld	a5,-40(s0)
 886 0740 BC67     		ld	a5,72(a5)
 887              		.loc 1 143 30
 888 0742 8193     		srli	a5,a5,32
 889              		.loc 1 143 16
 890 0744 13F7F70F 		andi	a4,a5,0xff
 891 0748 833784FD 		ld	a5,-40(s0)
 892 074c A38DE702 		sb	a4,59(a5)
 144:sha256.c      **** 	ctx->data[58] = ctx->bitlen >> 40;
 893              		.loc 1 144 21
 894 0750 833784FD 		ld	a5,-40(s0)
 895 0754 BC67     		ld	a5,72(a5)
 896              		.loc 1 144 30
 897 0756 A193     		srli	a5,a5,40
 898              		.loc 1 144 16
 899 0758 13F7F70F 		andi	a4,a5,0xff
 900 075c 833784FD 		ld	a5,-40(s0)
 901 0760 238DE702 		sb	a4,58(a5)
 145:sha256.c      **** 	ctx->data[57] = ctx->bitlen >> 48;
 902              		.loc 1 145 21
 903 0764 833784FD 		ld	a5,-40(s0)
 904 0768 BC67     		ld	a5,72(a5)
 905              		.loc 1 145 30
 906 076a C193     		srli	a5,a5,48
 907              		.loc 1 145 16
 908 076c 13F7F70F 		andi	a4,a5,0xff
 909 0770 833784FD 		ld	a5,-40(s0)
 910 0774 A38CE702 		sb	a4,57(a5)
 146:sha256.c      **** 	ctx->data[56] = ctx->bitlen >> 56;
 911              		.loc 1 146 21
 912 0778 833784FD 		ld	a5,-40(s0)
 913 077c BC67     		ld	a5,72(a5)
 914              		.loc 1 146 30
 915 077e E193     		srli	a5,a5,56
 916              		.loc 1 146 16
 917 0780 13F7F70F 		andi	a4,a5,0xff
 918 0784 833784FD 		ld	a5,-40(s0)
 919 0788 238CE702 		sb	a4,56(a5)
 147:sha256.c      **** 	sha256_transform(ctx, ctx->data);
 920              		.loc 1 147 27
 921 078c 833784FD 		ld	a5,-40(s0)
GAS LISTING /tmp/ccUgdhPb.s 			page 20


 922              		.loc 1 147 2
 923 0790 BE85     		mv	a1,a5
 924 0792 033584FD 		ld	a0,-40(s0)
 925 0796 97000000 		call	sha256_transform
 925      E7800000 
 148:sha256.c      **** 
 149:sha256.c      **** 	// Since this implementation uses little endian byte ordering and SHA uses big endian,
 150:sha256.c      **** 	// reverse all the bytes when copying the final state to the output hash.
 151:sha256.c      **** 	for (i = 0; i < 4; ++i) {
 926              		.loc 1 151 9
 927 079e 232604FE 		sw	zero,-20(s0)
 928              		.loc 1 151 2
 929 07a2 D5A2     		j	.L20
 930              	.L21:
 152:sha256.c      **** 		hash[i]      = (ctx->state[0] >> (24 - i * 8)) & 0x000000ff;
 931              		.loc 1 152 29 discriminator 3
 932 07a4 833784FD 		ld	a5,-40(s0)
 933 07a8 BC4B     		lw	a5,80(a5)
 934              		.loc 1 152 40 discriminator 3
 935 07aa 8D46     		li	a3,3
 936 07ac 0327C4FE 		lw	a4,-20(s0)
 937 07b0 3B87E640 		subw	a4,a3,a4
 938 07b4 0127     		sext.w	a4,a4
 939 07b6 1B173700 		slliw	a4,a4,3
 940 07ba 0127     		sext.w	a4,a4
 941              		.loc 1 152 33 discriminator 3
 942 07bc BBD7E700 		srlw	a5,a5,a4
 943 07c0 9B860700 		sext.w	a3,a5
 944              		.loc 1 152 7 discriminator 3
 945 07c4 8367C4FE 		lwu	a5,-20(s0)
 946 07c8 033704FD 		ld	a4,-48(s0)
 947 07cc BA97     		add	a5,a4,a5
 948              		.loc 1 152 16 discriminator 3
 949 07ce 3687     		mv	a4,a3
 950 07d0 1377F70F 		andi	a4,a4,0xff
 951 07d4 2380E700 		sb	a4,0(a5)
 153:sha256.c      **** 		hash[i + 4]  = (ctx->state[1] >> (24 - i * 8)) & 0x000000ff;
 952              		.loc 1 153 29 discriminator 3
 953 07d8 833784FD 		ld	a5,-40(s0)
 954 07dc FC4B     		lw	a5,84(a5)
 955              		.loc 1 153 40 discriminator 3
 956 07de 8D46     		li	a3,3
 957 07e0 0327C4FE 		lw	a4,-20(s0)
 958 07e4 3B87E640 		subw	a4,a3,a4
 959 07e8 0127     		sext.w	a4,a4
 960 07ea 1B173700 		slliw	a4,a4,3
 961 07ee 0127     		sext.w	a4,a4
 962              		.loc 1 153 33 discriminator 3
 963 07f0 BBD7E700 		srlw	a5,a5,a4
 964 07f4 9B860700 		sext.w	a3,a5
 965              		.loc 1 153 10 discriminator 3
 966 07f8 8327C4FE 		lw	a5,-20(s0)
 967 07fc 9127     		addiw	a5,a5,4
 968 07fe 8127     		sext.w	a5,a5
 969 0800 8217     		slli	a5,a5,32
 970 0802 8193     		srli	a5,a5,32
 971              		.loc 1 153 7 discriminator 3
GAS LISTING /tmp/ccUgdhPb.s 			page 21


 972 0804 033704FD 		ld	a4,-48(s0)
 973 0808 BA97     		add	a5,a4,a5
 974              		.loc 1 153 16 discriminator 3
 975 080a 3687     		mv	a4,a3
 976 080c 1377F70F 		andi	a4,a4,0xff
 977 0810 2380E700 		sb	a4,0(a5)
 154:sha256.c      **** 		hash[i + 8]  = (ctx->state[2] >> (24 - i * 8)) & 0x000000ff;
 978              		.loc 1 154 29 discriminator 3
 979 0814 833784FD 		ld	a5,-40(s0)
 980 0818 BC4F     		lw	a5,88(a5)
 981              		.loc 1 154 40 discriminator 3
 982 081a 8D46     		li	a3,3
 983 081c 0327C4FE 		lw	a4,-20(s0)
 984 0820 3B87E640 		subw	a4,a3,a4
 985 0824 0127     		sext.w	a4,a4
 986 0826 1B173700 		slliw	a4,a4,3
 987 082a 0127     		sext.w	a4,a4
 988              		.loc 1 154 33 discriminator 3
 989 082c BBD7E700 		srlw	a5,a5,a4
 990 0830 9B860700 		sext.w	a3,a5
 991              		.loc 1 154 10 discriminator 3
 992 0834 8327C4FE 		lw	a5,-20(s0)
 993 0838 A127     		addiw	a5,a5,8
 994 083a 8127     		sext.w	a5,a5
 995 083c 8217     		slli	a5,a5,32
 996 083e 8193     		srli	a5,a5,32
 997              		.loc 1 154 7 discriminator 3
 998 0840 033704FD 		ld	a4,-48(s0)
 999 0844 BA97     		add	a5,a4,a5
 1000              		.loc 1 154 16 discriminator 3
 1001 0846 3687     		mv	a4,a3
 1002 0848 1377F70F 		andi	a4,a4,0xff
 1003 084c 2380E700 		sb	a4,0(a5)
 155:sha256.c      **** 		hash[i + 12] = (ctx->state[3] >> (24 - i * 8)) & 0x000000ff;
 1004              		.loc 1 155 29 discriminator 3
 1005 0850 833784FD 		ld	a5,-40(s0)
 1006 0854 FC4F     		lw	a5,92(a5)
 1007              		.loc 1 155 40 discriminator 3
 1008 0856 8D46     		li	a3,3
 1009 0858 0327C4FE 		lw	a4,-20(s0)
 1010 085c 3B87E640 		subw	a4,a3,a4
 1011 0860 0127     		sext.w	a4,a4
 1012 0862 1B173700 		slliw	a4,a4,3
 1013 0866 0127     		sext.w	a4,a4
 1014              		.loc 1 155 33 discriminator 3
 1015 0868 BBD7E700 		srlw	a5,a5,a4
 1016 086c 9B860700 		sext.w	a3,a5
 1017              		.loc 1 155 10 discriminator 3
 1018 0870 8327C4FE 		lw	a5,-20(s0)
 1019 0874 B127     		addiw	a5,a5,12
 1020 0876 8127     		sext.w	a5,a5
 1021 0878 8217     		slli	a5,a5,32
 1022 087a 8193     		srli	a5,a5,32
 1023              		.loc 1 155 7 discriminator 3
 1024 087c 033704FD 		ld	a4,-48(s0)
 1025 0880 BA97     		add	a5,a4,a5
 1026              		.loc 1 155 16 discriminator 3
GAS LISTING /tmp/ccUgdhPb.s 			page 22


 1027 0882 3687     		mv	a4,a3
 1028 0884 1377F70F 		andi	a4,a4,0xff
 1029 0888 2380E700 		sb	a4,0(a5)
 156:sha256.c      **** 		hash[i + 16] = (ctx->state[4] >> (24 - i * 8)) & 0x000000ff;
 1030              		.loc 1 156 29 discriminator 3
 1031 088c 833784FD 		ld	a5,-40(s0)
 1032 0890 BC53     		lw	a5,96(a5)
 1033              		.loc 1 156 40 discriminator 3
 1034 0892 8D46     		li	a3,3
 1035 0894 0327C4FE 		lw	a4,-20(s0)
 1036 0898 3B87E640 		subw	a4,a3,a4
 1037 089c 0127     		sext.w	a4,a4
 1038 089e 1B173700 		slliw	a4,a4,3
 1039 08a2 0127     		sext.w	a4,a4
 1040              		.loc 1 156 33 discriminator 3
 1041 08a4 BBD7E700 		srlw	a5,a5,a4
 1042 08a8 9B860700 		sext.w	a3,a5
 1043              		.loc 1 156 10 discriminator 3
 1044 08ac 8327C4FE 		lw	a5,-20(s0)
 1045 08b0 C127     		addiw	a5,a5,16
 1046 08b2 8127     		sext.w	a5,a5
 1047 08b4 8217     		slli	a5,a5,32
 1048 08b6 8193     		srli	a5,a5,32
 1049              		.loc 1 156 7 discriminator 3
 1050 08b8 033704FD 		ld	a4,-48(s0)
 1051 08bc BA97     		add	a5,a4,a5
 1052              		.loc 1 156 16 discriminator 3
 1053 08be 3687     		mv	a4,a3
 1054 08c0 1377F70F 		andi	a4,a4,0xff
 1055 08c4 2380E700 		sb	a4,0(a5)
 157:sha256.c      **** 		hash[i + 20] = (ctx->state[5] >> (24 - i * 8)) & 0x000000ff;
 1056              		.loc 1 157 29 discriminator 3
 1057 08c8 833784FD 		ld	a5,-40(s0)
 1058 08cc FC53     		lw	a5,100(a5)
 1059              		.loc 1 157 40 discriminator 3
 1060 08ce 8D46     		li	a3,3
 1061 08d0 0327C4FE 		lw	a4,-20(s0)
 1062 08d4 3B87E640 		subw	a4,a3,a4
 1063 08d8 0127     		sext.w	a4,a4
 1064 08da 1B173700 		slliw	a4,a4,3
 1065 08de 0127     		sext.w	a4,a4
 1066              		.loc 1 157 33 discriminator 3
 1067 08e0 BBD7E700 		srlw	a5,a5,a4
 1068 08e4 9B860700 		sext.w	a3,a5
 1069              		.loc 1 157 10 discriminator 3
 1070 08e8 8327C4FE 		lw	a5,-20(s0)
 1071 08ec D127     		addiw	a5,a5,20
 1072 08ee 8127     		sext.w	a5,a5
 1073 08f0 8217     		slli	a5,a5,32
 1074 08f2 8193     		srli	a5,a5,32
 1075              		.loc 1 157 7 discriminator 3
 1076 08f4 033704FD 		ld	a4,-48(s0)
 1077 08f8 BA97     		add	a5,a4,a5
 1078              		.loc 1 157 16 discriminator 3
 1079 08fa 3687     		mv	a4,a3
 1080 08fc 1377F70F 		andi	a4,a4,0xff
 1081 0900 2380E700 		sb	a4,0(a5)
GAS LISTING /tmp/ccUgdhPb.s 			page 23


 158:sha256.c      **** 		hash[i + 24] = (ctx->state[6] >> (24 - i * 8)) & 0x000000ff;
 1082              		.loc 1 158 29 discriminator 3
 1083 0904 833784FD 		ld	a5,-40(s0)
 1084 0908 BC57     		lw	a5,104(a5)
 1085              		.loc 1 158 40 discriminator 3
 1086 090a 8D46     		li	a3,3
 1087 090c 0327C4FE 		lw	a4,-20(s0)
 1088 0910 3B87E640 		subw	a4,a3,a4
 1089 0914 0127     		sext.w	a4,a4
 1090 0916 1B173700 		slliw	a4,a4,3
 1091 091a 0127     		sext.w	a4,a4
 1092              		.loc 1 158 33 discriminator 3
 1093 091c BBD7E700 		srlw	a5,a5,a4
 1094 0920 9B860700 		sext.w	a3,a5
 1095              		.loc 1 158 10 discriminator 3
 1096 0924 8327C4FE 		lw	a5,-20(s0)
 1097 0928 E127     		addiw	a5,a5,24
 1098 092a 8127     		sext.w	a5,a5
 1099 092c 8217     		slli	a5,a5,32
 1100 092e 8193     		srli	a5,a5,32
 1101              		.loc 1 158 7 discriminator 3
 1102 0930 033704FD 		ld	a4,-48(s0)
 1103 0934 BA97     		add	a5,a4,a5
 1104              		.loc 1 158 16 discriminator 3
 1105 0936 3687     		mv	a4,a3
 1106 0938 1377F70F 		andi	a4,a4,0xff
 1107 093c 2380E700 		sb	a4,0(a5)
 159:sha256.c      **** 		hash[i + 28] = (ctx->state[7] >> (24 - i * 8)) & 0x000000ff;
 1108              		.loc 1 159 29 discriminator 3
 1109 0940 833784FD 		ld	a5,-40(s0)
 1110 0944 FC57     		lw	a5,108(a5)
 1111              		.loc 1 159 40 discriminator 3
 1112 0946 8D46     		li	a3,3
 1113 0948 0327C4FE 		lw	a4,-20(s0)
 1114 094c 3B87E640 		subw	a4,a3,a4
 1115 0950 0127     		sext.w	a4,a4
 1116 0952 1B173700 		slliw	a4,a4,3
 1117 0956 0127     		sext.w	a4,a4
 1118              		.loc 1 159 33 discriminator 3
 1119 0958 BBD7E700 		srlw	a5,a5,a4
 1120 095c 9B860700 		sext.w	a3,a5
 1121              		.loc 1 159 10 discriminator 3
 1122 0960 8327C4FE 		lw	a5,-20(s0)
 1123 0964 F127     		addiw	a5,a5,28
 1124 0966 8127     		sext.w	a5,a5
 1125 0968 8217     		slli	a5,a5,32
 1126 096a 8193     		srli	a5,a5,32
 1127              		.loc 1 159 7 discriminator 3
 1128 096c 033704FD 		ld	a4,-48(s0)
 1129 0970 BA97     		add	a5,a4,a5
 1130              		.loc 1 159 16 discriminator 3
 1131 0972 3687     		mv	a4,a3
 1132 0974 1377F70F 		andi	a4,a4,0xff
 1133 0978 2380E700 		sb	a4,0(a5)
 151:sha256.c      **** 		hash[i]      = (ctx->state[0] >> (24 - i * 8)) & 0x000000ff;
 1134              		.loc 1 151 21 discriminator 3
 1135 097c 8327C4FE 		lw	a5,-20(s0)
GAS LISTING /tmp/ccUgdhPb.s 			page 24


 1136 0980 8527     		addiw	a5,a5,1
 1137 0982 2326F4FE 		sw	a5,-20(s0)
 1138              	.L20:
 151:sha256.c      **** 		hash[i]      = (ctx->state[0] >> (24 - i * 8)) & 0x000000ff;
 1139              		.loc 1 151 2 discriminator 1
 1140 0986 8327C4FE 		lw	a5,-20(s0)
 1141 098a 1B870700 		sext.w	a4,a5
 1142 098e 8D47     		li	a5,3
 1143 0990 E3FAE7E0 		bleu	a4,a5,.L21
 160:sha256.c      **** 	}
 161:sha256.c      **** }
 1144              		.loc 1 161 1
 1145 0994 0100     		nop
 1146 0996 0100     		nop
 1147 0998 A270     		ld	ra,40(sp)
 1148              		.cfi_restore 1
 1149 099a 0274     		ld	s0,32(sp)
 1150              		.cfi_restore 8
 1151              		.cfi_def_cfa 2, 48
 1152 099c 4561     		addi	sp,sp,48
 1153              		.cfi_def_cfa_offset 0
 1154 099e 8280     		jr	ra
 1155              		.cfi_endproc
 1156              	.LFE7:
 1157              		.size	sha256_final, .-sha256_final
 1158              		.section	.rodata
 1159              		.align	3
 1160              	.LC0:
 1161 0100 506C6561 		.string	"Please input string: "
 1161      73652069 
 1161      6E707574 
 1161      20737472 
 1161      696E673A 
 1162 0116 0000     		.align	3
 1163              	.LC1:
 1164 0118 257300   		.string	"%s"
 1165 011b 00000000 		.align	3
 1165      00
 1166              	.LC2:
 1167 0120 68617368 		.string	"hash hex: "
 1167      20686578 
 1167      3A2000
 1168 012b 00000000 		.align	3
 1168      00
 1169              	.LC3:
 1170 0130 25303278 		.string	"%02x"
 1170      00
 1171              		.text
 1172              		.align	1
 1173              		.globl	main
 1174              		.type	main, @function
 1175              	main:
 1176              	.LFB8:
 162:sha256.c      **** 
 163:sha256.c      **** int main()
 164:sha256.c      **** {
 1177              		.loc 1 164 1
GAS LISTING /tmp/ccUgdhPb.s 			page 25


 1178              		.cfi_startproc
 1179 09a0 6171     		addi	sp,sp,-432
 1180              		.cfi_def_cfa_offset 432
 1181 09a2 06F7     		sd	ra,424(sp)
 1182 09a4 22F3     		sd	s0,416(sp)
 1183              		.cfi_offset 1, -8
 1184              		.cfi_offset 8, -16
 1185 09a6 001B     		addi	s0,sp,432
 1186              		.cfi_def_cfa 8, 0
 165:sha256.c      **** 	
 166:sha256.c      **** 	BYTE text[INPUT_SIZE];
 167:sha256.c      **** 	BYTE buf[SHA256_BLOCK_SIZE];
 168:sha256.c      **** 	SHA256_CTX ctx;
 169:sha256.c      **** 	
 170:sha256.c      **** 	//input the string to be encrypted
 171:sha256.c      **** 	printf("Please input string: ");
 1187              		.loc 1 171 2
 1188 09a8 B7070000 		lui	a5,%hi(.LC0)
 1189 09ac 13850700 		addi	a0,a5,%lo(.LC0)
 1190 09b0 97000000 		call	printf
 1190      E7800000 
 172:sha256.c      **** 	scanf("%s",text);
 1191              		.loc 1 172 2
 1192 09b8 930784EE 		addi	a5,s0,-280
 1193 09bc BE85     		mv	a1,a5
 1194 09be B7070000 		lui	a5,%hi(.LC1)
 1195 09c2 13850700 		addi	a0,a5,%lo(.LC1)
 1196 09c6 97000000 		call	scanf
 1196      E7800000 
 173:sha256.c      **** 
 174:sha256.c      ****     //sha256
 175:sha256.c      **** 	sha256_init(&ctx);
 1197              		.loc 1 175 2
 1198 09ce 930784E5 		addi	a5,s0,-424
 1199 09d2 3E85     		mv	a0,a5
 1200 09d4 97000000 		call	sha256_init
 1200      E7800000 
 176:sha256.c      **** 	sha256_update(&ctx, text, strlen(text));
 1201              		.loc 1 176 2
 1202 09dc 930784EE 		addi	a5,s0,-280
 1203 09e0 3E85     		mv	a0,a5
 1204 09e2 97000000 		call	strlen
 1204      E7800000 
 1205 09ea AA86     		mv	a3,a0
 1206 09ec 130784EE 		addi	a4,s0,-280
 1207 09f0 930784E5 		addi	a5,s0,-424
 1208 09f4 3686     		mv	a2,a3
 1209 09f6 BA85     		mv	a1,a4
 1210 09f8 3E85     		mv	a0,a5
 1211 09fa 97000000 		call	sha256_update
 1211      E7800000 
 177:sha256.c      **** 	sha256_final(&ctx, buf);
 1212              		.loc 1 177 2
 1213 0a02 130784EC 		addi	a4,s0,-312
 1214 0a06 930784E5 		addi	a5,s0,-424
 1215 0a0a BA85     		mv	a1,a4
 1216 0a0c 3E85     		mv	a0,a5
GAS LISTING /tmp/ccUgdhPb.s 			page 26


 1217 0a0e 97000000 		call	sha256_final
 1217      E7800000 
 178:sha256.c      **** 
 179:sha256.c      **** 	//output SHA256 hash
 180:sha256.c      **** 	printf("hash hex: ");
 1218              		.loc 1 180 2
 1219 0a16 B7070000 		lui	a5,%hi(.LC2)
 1220 0a1a 13850700 		addi	a0,a5,%lo(.LC2)
 1221 0a1e 97000000 		call	printf
 1221      E7800000 
 1222              	.LBB2:
 181:sha256.c      **** 	for(int i = 0; i < SHA256_BLOCK_SIZE; i++){
 1223              		.loc 1 181 10
 1224 0a26 232604FE 		sw	zero,-20(s0)
 1225              		.loc 1 181 2
 1226 0a2a 3DA0     		j	.L23
 1227              	.L24:
 182:sha256.c      **** 		printf("%02x",buf[i]);
 1228              		.loc 1 182 20 discriminator 3
 1229 0a2c 8327C4FE 		lw	a5,-20(s0)
 1230 0a30 130704FF 		addi	a4,s0,-16
 1231 0a34 BA97     		add	a5,a4,a5
 1232 0a36 83C787ED 		lbu	a5,-296(a5)
 1233              		.loc 1 182 3 discriminator 3
 1234 0a3a 8127     		sext.w	a5,a5
 1235 0a3c BE85     		mv	a1,a5
 1236 0a3e B7070000 		lui	a5,%hi(.LC3)
 1237 0a42 13850700 		addi	a0,a5,%lo(.LC3)
 1238 0a46 97000000 		call	printf
 1238      E7800000 
 181:sha256.c      **** 	for(int i = 0; i < SHA256_BLOCK_SIZE; i++){
 1239              		.loc 1 181 41 discriminator 3
 1240 0a4e 8327C4FE 		lw	a5,-20(s0)
 1241 0a52 8527     		addiw	a5,a5,1
 1242 0a54 2326F4FE 		sw	a5,-20(s0)
 1243              	.L23:
 181:sha256.c      **** 	for(int i = 0; i < SHA256_BLOCK_SIZE; i++){
 1244              		.loc 1 181 2 discriminator 1
 1245 0a58 8327C4FE 		lw	a5,-20(s0)
 1246 0a5c 1B870700 		sext.w	a4,a5
 1247 0a60 FD47     		li	a5,31
 1248 0a62 E3D5E7FC 		ble	a4,a5,.L24
 1249              	.LBE2:
 183:sha256.c      **** 	}
 184:sha256.c      **** 	printf("\n");
 1250              		.loc 1 184 2
 1251 0a66 2945     		li	a0,10
 1252 0a68 97000000 		call	putchar
 1252      E7800000 
 185:sha256.c      **** 	
 186:sha256.c      **** 	return(0);
 1253              		.loc 1 186 8
 1254 0a70 8147     		li	a5,0
 187:sha256.c      **** }
 1255              		.loc 1 187 1
 1256 0a72 3E85     		mv	a0,a5
 1257 0a74 BA70     		ld	ra,424(sp)
GAS LISTING /tmp/ccUgdhPb.s 			page 27


 1258              		.cfi_restore 1
 1259 0a76 1A74     		ld	s0,416(sp)
 1260              		.cfi_restore 8
 1261              		.cfi_def_cfa 2, 432
 1262 0a78 5D61     		addi	sp,sp,432
 1263              		.cfi_def_cfa_offset 0
 1264 0a7a 8280     		jr	ra
 1265              		.cfi_endproc
 1266              	.LFE8:
 1267              		.size	main, .-main
 1268              	.Letext0:
 1269              		.file 2 "/opt/riscv/lib/gcc/riscv64-unknown-elf/10.1.0/include/stddef.h"
 1270              		.section	.debug_info,"",@progbits
 1271              	.Ldebug_info0:
 1272 0000 AB030000 		.4byte	0x3ab
 1273 0004 0400     		.2byte	0x4
 1274 0006 00000000 		.4byte	.Ldebug_abbrev0
 1275 000a 08       		.byte	0x8
 1276 000b 01       		.byte	0x1
 1277 000c 00000000 		.4byte	.LASF26
 1278 0010 0C       		.byte	0xc
 1279 0011 00000000 		.4byte	.LASF27
 1280 0015 00000000 		.4byte	.LASF28
 1281 0019 00000000 		.8byte	.Ltext0
 1281      00000000 
 1282 0021 00000000 		.8byte	.Letext0-.Ltext0
 1282      00000000 
 1283 0029 00000000 		.4byte	.Ldebug_line0
 1284 002d 02       		.byte	0x2
 1285 002e 08       		.byte	0x8
 1286 002f 05       		.byte	0x5
 1287 0030 00000000 		.4byte	.LASF0
 1288 0034 03       		.byte	0x3
 1289 0035 00000000 		.4byte	.LASF11
 1290 0039 02       		.byte	0x2
 1291 003a D1       		.byte	0xd1
 1292 003b 17       		.byte	0x17
 1293 003c 40000000 		.4byte	0x40
 1294 0040 02       		.byte	0x2
 1295 0041 08       		.byte	0x8
 1296 0042 07       		.byte	0x7
 1297 0043 00000000 		.4byte	.LASF1
 1298 0047 04       		.byte	0x4
 1299 0048 04       		.byte	0x4
 1300 0049 05       		.byte	0x5
 1301 004a 696E7400 		.string	"int"
 1302 004e 02       		.byte	0x2
 1303 004f 08       		.byte	0x8
 1304 0050 05       		.byte	0x5
 1305 0051 00000000 		.4byte	.LASF2
 1306 0055 02       		.byte	0x2
 1307 0056 10       		.byte	0x10
 1308 0057 04       		.byte	0x4
 1309 0058 00000000 		.4byte	.LASF3
 1310 005c 02       		.byte	0x2
 1311 005d 04       		.byte	0x4
 1312 005e 07       		.byte	0x7
GAS LISTING /tmp/ccUgdhPb.s 			page 28


 1313 005f 00000000 		.4byte	.LASF4
 1314 0063 02       		.byte	0x2
 1315 0064 01       		.byte	0x1
 1316 0065 06       		.byte	0x6
 1317 0066 00000000 		.4byte	.LASF5
 1318 006a 02       		.byte	0x2
 1319 006b 01       		.byte	0x1
 1320 006c 08       		.byte	0x8
 1321 006d 00000000 		.4byte	.LASF6
 1322 0071 02       		.byte	0x2
 1323 0072 02       		.byte	0x2
 1324 0073 05       		.byte	0x5
 1325 0074 00000000 		.4byte	.LASF7
 1326 0078 02       		.byte	0x2
 1327 0079 02       		.byte	0x2
 1328 007a 07       		.byte	0x7
 1329 007b 00000000 		.4byte	.LASF8
 1330 007f 02       		.byte	0x2
 1331 0080 01       		.byte	0x1
 1332 0081 08       		.byte	0x8
 1333 0082 00000000 		.4byte	.LASF9
 1334 0086 02       		.byte	0x2
 1335 0087 08       		.byte	0x8
 1336 0088 07       		.byte	0x7
 1337 0089 00000000 		.4byte	.LASF10
 1338 008d 03       		.byte	0x3
 1339 008e 00000000 		.4byte	.LASF12
 1340 0092 01       		.byte	0x1
 1341 0093 08       		.byte	0x8
 1342 0094 17       		.byte	0x17
 1343 0095 6A000000 		.4byte	0x6a
 1344 0099 05       		.byte	0x5
 1345 009a 8D000000 		.4byte	0x8d
 1346 009e 03       		.byte	0x3
 1347 009f 00000000 		.4byte	.LASF13
 1348 00a3 01       		.byte	0x1
 1349 00a4 09       		.byte	0x9
 1350 00a5 17       		.byte	0x17
 1351 00a6 5C000000 		.4byte	0x5c
 1352 00aa 05       		.byte	0x5
 1353 00ab 9E000000 		.4byte	0x9e
 1354 00af 06       		.byte	0x6
 1355 00b0 70       		.byte	0x70
 1356 00b1 01       		.byte	0x1
 1357 00b2 0B       		.byte	0xb
 1358 00b3 09       		.byte	0x9
 1359 00b4 ED000000 		.4byte	0xed
 1360 00b8 07       		.byte	0x7
 1361 00b9 00000000 		.4byte	.LASF14
 1362 00bd 01       		.byte	0x1
 1363 00be 0C       		.byte	0xc
 1364 00bf 07       		.byte	0x7
 1365 00c0 ED000000 		.4byte	0xed
 1366 00c4 00       		.byte	0
 1367 00c5 07       		.byte	0x7
 1368 00c6 00000000 		.4byte	.LASF15
 1369 00ca 01       		.byte	0x1
GAS LISTING /tmp/ccUgdhPb.s 			page 29


 1370 00cb 0D       		.byte	0xd
 1371 00cc 07       		.byte	0x7
 1372 00cd 9E000000 		.4byte	0x9e
 1373 00d1 40       		.byte	0x40
 1374 00d2 07       		.byte	0x7
 1375 00d3 00000000 		.4byte	.LASF16
 1376 00d7 01       		.byte	0x1
 1377 00d8 0E       		.byte	0xe
 1378 00d9 15       		.byte	0x15
 1379 00da 86000000 		.4byte	0x86
 1380 00de 48       		.byte	0x48
 1381 00df 07       		.byte	0x7
 1382 00e0 00000000 		.4byte	.LASF17
 1383 00e4 01       		.byte	0x1
 1384 00e5 0F       		.byte	0xf
 1385 00e6 07       		.byte	0x7
 1386 00e7 FD000000 		.4byte	0xfd
 1387 00eb 50       		.byte	0x50
 1388 00ec 00       		.byte	0
 1389 00ed 08       		.byte	0x8
 1390 00ee 8D000000 		.4byte	0x8d
 1391 00f2 FD000000 		.4byte	0xfd
 1392 00f6 09       		.byte	0x9
 1393 00f7 40000000 		.4byte	0x40
 1394 00fb 3F       		.byte	0x3f
 1395 00fc 00       		.byte	0
 1396 00fd 08       		.byte	0x8
 1397 00fe 9E000000 		.4byte	0x9e
 1398 0102 0D010000 		.4byte	0x10d
 1399 0106 09       		.byte	0x9
 1400 0107 40000000 		.4byte	0x40
 1401 010b 07       		.byte	0x7
 1402 010c 00       		.byte	0
 1403 010d 03       		.byte	0x3
 1404 010e 00000000 		.4byte	.LASF18
 1405 0112 01       		.byte	0x1
 1406 0113 10       		.byte	0x10
 1407 0114 03       		.byte	0x3
 1408 0115 AF000000 		.4byte	0xaf
 1409 0119 08       		.byte	0x8
 1410 011a AA000000 		.4byte	0xaa
 1411 011e 29010000 		.4byte	0x129
 1412 0122 09       		.byte	0x9
 1413 0123 40000000 		.4byte	0x40
 1414 0127 3F       		.byte	0x3f
 1415 0128 00       		.byte	0
 1416 0129 05       		.byte	0x5
 1417 012a 19010000 		.4byte	0x119
 1418 012e 0A       		.byte	0xa
 1419 012f 6B00     		.string	"k"
 1420 0131 01       		.byte	0x1
 1421 0132 23       		.byte	0x23
 1422 0133 13       		.byte	0x13
 1423 0134 29010000 		.4byte	0x129
 1424 0138 09       		.byte	0x9
 1425 0139 03       		.byte	0x3
 1426 013a 00000000 		.8byte	k
GAS LISTING /tmp/ccUgdhPb.s 			page 30


 1426      00000000 
 1427 0142 0B       		.byte	0xb
 1428 0143 00000000 		.4byte	.LASF20
 1429 0147 01       		.byte	0x1
 1430 0148 A3       		.byte	0xa3
 1431 0149 05       		.byte	0x5
 1432 014a 47000000 		.4byte	0x47
 1433 014e 00000000 		.8byte	.LFB8
 1433      00000000 
 1434 0156 00000000 		.8byte	.LFE8-.LFB8
 1434      00000000 
 1435 015e 01       		.byte	0x1
 1436 015f 9C       		.byte	0x9c
 1437 0160 B4010000 		.4byte	0x1b4
 1438 0164 0C       		.byte	0xc
 1439 0165 00000000 		.4byte	.LASF19
 1440 0169 01       		.byte	0x1
 1441 016a A6       		.byte	0xa6
 1442 016b 07       		.byte	0x7
 1443 016c B4010000 		.4byte	0x1b4
 1444 0170 03       		.byte	0x3
 1445 0171 91       		.byte	0x91
 1446 0172 E87D     		.byte	0xe8,0x7d
 1447 0174 0A       		.byte	0xa
 1448 0175 62756600 		.string	"buf"
 1449 0179 01       		.byte	0x1
 1450 017a A7       		.byte	0xa7
 1451 017b 07       		.byte	0x7
 1452 017c C4010000 		.4byte	0x1c4
 1453 0180 03       		.byte	0x3
 1454 0181 91       		.byte	0x91
 1455 0182 C87D     		.byte	0xc8,0x7d
 1456 0184 0A       		.byte	0xa
 1457 0185 63747800 		.string	"ctx"
 1458 0189 01       		.byte	0x1
 1459 018a A8       		.byte	0xa8
 1460 018b 0D       		.byte	0xd
 1461 018c 0D010000 		.4byte	0x10d
 1462 0190 03       		.byte	0x3
 1463 0191 91       		.byte	0x91
 1464 0192 D87C     		.byte	0xd8,0x7c
 1465 0194 0D       		.byte	0xd
 1466 0195 00000000 		.8byte	.LBB2
 1466      00000000 
 1467 019d 00000000 		.8byte	.LBE2-.LBB2
 1467      00000000 
 1468 01a5 0A       		.byte	0xa
 1469 01a6 6900     		.string	"i"
 1470 01a8 01       		.byte	0x1
 1471 01a9 B5       		.byte	0xb5
 1472 01aa 0A       		.byte	0xa
 1473 01ab 47000000 		.4byte	0x47
 1474 01af 02       		.byte	0x2
 1475 01b0 91       		.byte	0x91
 1476 01b1 6C       		.byte	0x6c
 1477 01b2 00       		.byte	0
 1478 01b3 00       		.byte	0
GAS LISTING /tmp/ccUgdhPb.s 			page 31


 1479 01b4 08       		.byte	0x8
 1480 01b5 8D000000 		.4byte	0x8d
 1481 01b9 C4010000 		.4byte	0x1c4
 1482 01bd 09       		.byte	0x9
 1483 01be 40000000 		.4byte	0x40
 1484 01c2 FF       		.byte	0xff
 1485 01c3 00       		.byte	0
 1486 01c4 08       		.byte	0x8
 1487 01c5 8D000000 		.4byte	0x8d
 1488 01c9 D4010000 		.4byte	0x1d4
 1489 01cd 09       		.byte	0x9
 1490 01ce 40000000 		.4byte	0x40
 1491 01d2 1F       		.byte	0x1f
 1492 01d3 00       		.byte	0
 1493 01d4 0E       		.byte	0xe
 1494 01d5 00000000 		.4byte	.LASF21
 1495 01d9 01       		.byte	0x1
 1496 01da 75       		.byte	0x75
 1497 01db 06       		.byte	0x6
 1498 01dc 00000000 		.8byte	.LFB7
 1498      00000000 
 1499 01e4 00000000 		.8byte	.LFE7-.LFB7
 1499      00000000 
 1500 01ec 01       		.byte	0x1
 1501 01ed 9C       		.byte	0x9c
 1502 01ee 1E020000 		.4byte	0x21e
 1503 01f2 0F       		.byte	0xf
 1504 01f3 63747800 		.string	"ctx"
 1505 01f7 01       		.byte	0x1
 1506 01f8 75       		.byte	0x75
 1507 01f9 1F       		.byte	0x1f
 1508 01fa 1E020000 		.4byte	0x21e
 1509 01fe 02       		.byte	0x2
 1510 01ff 91       		.byte	0x91
 1511 0200 58       		.byte	0x58
 1512 0201 10       		.byte	0x10
 1513 0202 00000000 		.4byte	.LASF22
 1514 0206 01       		.byte	0x1
 1515 0207 75       		.byte	0x75
 1516 0208 29       		.byte	0x29
 1517 0209 24020000 		.4byte	0x224
 1518 020d 02       		.byte	0x2
 1519 020e 91       		.byte	0x91
 1520 020f 50       		.byte	0x50
 1521 0210 0A       		.byte	0xa
 1522 0211 6900     		.string	"i"
 1523 0213 01       		.byte	0x1
 1524 0214 77       		.byte	0x77
 1525 0215 07       		.byte	0x7
 1526 0216 9E000000 		.4byte	0x9e
 1527 021a 02       		.byte	0x2
 1528 021b 91       		.byte	0x91
 1529 021c 6C       		.byte	0x6c
 1530 021d 00       		.byte	0
 1531 021e 11       		.byte	0x11
 1532 021f 08       		.byte	0x8
 1533 0220 0D010000 		.4byte	0x10d
GAS LISTING /tmp/ccUgdhPb.s 			page 32


 1534 0224 11       		.byte	0x11
 1535 0225 08       		.byte	0x8
 1536 0226 8D000000 		.4byte	0x8d
 1537 022a 0E       		.byte	0xe
 1538 022b 00000000 		.4byte	.LASF23
 1539 022f 01       		.byte	0x1
 1540 0230 66       		.byte	0x66
 1541 0231 06       		.byte	0x6
 1542 0232 00000000 		.8byte	.LFB6
 1542      00000000 
 1543 023a 00000000 		.8byte	.LFE6-.LFB6
 1543      00000000 
 1544 0242 01       		.byte	0x1
 1545 0243 9C       		.byte	0x9c
 1546 0244 83020000 		.4byte	0x283
 1547 0248 0F       		.byte	0xf
 1548 0249 63747800 		.string	"ctx"
 1549 024d 01       		.byte	0x1
 1550 024e 66       		.byte	0x66
 1551 024f 20       		.byte	0x20
 1552 0250 1E020000 		.4byte	0x21e
 1553 0254 02       		.byte	0x2
 1554 0255 91       		.byte	0x91
 1555 0256 58       		.byte	0x58
 1556 0257 10       		.byte	0x10
 1557 0258 00000000 		.4byte	.LASF14
 1558 025c 01       		.byte	0x1
 1559 025d 66       		.byte	0x66
 1560 025e 30       		.byte	0x30
 1561 025f 83020000 		.4byte	0x283
 1562 0263 02       		.byte	0x2
 1563 0264 91       		.byte	0x91
 1564 0265 50       		.byte	0x50
 1565 0266 0F       		.byte	0xf
 1566 0267 6C656E00 		.string	"len"
 1567 026b 01       		.byte	0x1
 1568 026c 66       		.byte	0x66
 1569 026d 3F       		.byte	0x3f
 1570 026e 34000000 		.4byte	0x34
 1571 0272 02       		.byte	0x2
 1572 0273 91       		.byte	0x91
 1573 0274 48       		.byte	0x48
 1574 0275 0A       		.byte	0xa
 1575 0276 6900     		.string	"i"
 1576 0278 01       		.byte	0x1
 1577 0279 68       		.byte	0x68
 1578 027a 07       		.byte	0x7
 1579 027b 9E000000 		.4byte	0x9e
 1580 027f 02       		.byte	0x2
 1581 0280 91       		.byte	0x91
 1582 0281 6C       		.byte	0x6c
 1583 0282 00       		.byte	0
 1584 0283 11       		.byte	0x11
 1585 0284 08       		.byte	0x8
 1586 0285 99000000 		.4byte	0x99
 1587 0289 12       		.byte	0x12
 1588 028a 00000000 		.4byte	.LASF24
GAS LISTING /tmp/ccUgdhPb.s 			page 33


 1589 028e 01       		.byte	0x1
 1590 028f 58       		.byte	0x58
 1591 0290 06       		.byte	0x6
 1592 0291 00000000 		.8byte	.LFB5
 1592      00000000 
 1593 0299 00000000 		.8byte	.LFE5-.LFB5
 1593      00000000 
 1594 02a1 01       		.byte	0x1
 1595 02a2 9C       		.byte	0x9c
 1596 02a3 B7020000 		.4byte	0x2b7
 1597 02a7 0F       		.byte	0xf
 1598 02a8 63747800 		.string	"ctx"
 1599 02ac 01       		.byte	0x1
 1600 02ad 58       		.byte	0x58
 1601 02ae 1E       		.byte	0x1e
 1602 02af 1E020000 		.4byte	0x21e
 1603 02b3 02       		.byte	0x2
 1604 02b4 91       		.byte	0x91
 1605 02b5 68       		.byte	0x68
 1606 02b6 00       		.byte	0
 1607 02b7 12       		.byte	0x12
 1608 02b8 00000000 		.4byte	.LASF25
 1609 02bc 01       		.byte	0x1
 1610 02bd 2F       		.byte	0x2f
 1611 02be 06       		.byte	0x6
 1612 02bf 00000000 		.8byte	.LFB4
 1612      00000000 
 1613 02c7 00000000 		.8byte	.LFE4-.LFB4
 1613      00000000 
 1614 02cf 01       		.byte	0x1
 1615 02d0 9C       		.byte	0x9c
 1616 02d1 A2030000 		.4byte	0x3a2
 1617 02d5 0F       		.byte	0xf
 1618 02d6 63747800 		.string	"ctx"
 1619 02da 01       		.byte	0x1
 1620 02db 2F       		.byte	0x2f
 1621 02dc 23       		.byte	0x23
 1622 02dd 1E020000 		.4byte	0x21e
 1623 02e1 03       		.byte	0x3
 1624 02e2 91       		.byte	0x91
 1625 02e3 B87D     		.byte	0xb8,0x7d
 1626 02e5 10       		.byte	0x10
 1627 02e6 00000000 		.4byte	.LASF14
 1628 02ea 01       		.byte	0x1
 1629 02eb 2F       		.byte	0x2f
 1630 02ec 33       		.byte	0x33
 1631 02ed 83020000 		.4byte	0x283
 1632 02f1 03       		.byte	0x3
 1633 02f2 91       		.byte	0x91
 1634 02f3 B07D     		.byte	0xb0,0x7d
 1635 02f5 0A       		.byte	0xa
 1636 02f6 6100     		.string	"a"
 1637 02f8 01       		.byte	0x1
 1638 02f9 31       		.byte	0x31
 1639 02fa 07       		.byte	0x7
 1640 02fb 9E000000 		.4byte	0x9e
 1641 02ff 02       		.byte	0x2
GAS LISTING /tmp/ccUgdhPb.s 			page 34


 1642 0300 91       		.byte	0x91
 1643 0301 6C       		.byte	0x6c
 1644 0302 0A       		.byte	0xa
 1645 0303 6200     		.string	"b"
 1646 0305 01       		.byte	0x1
 1647 0306 31       		.byte	0x31
 1648 0307 0A       		.byte	0xa
 1649 0308 9E000000 		.4byte	0x9e
 1650 030c 02       		.byte	0x2
 1651 030d 91       		.byte	0x91
 1652 030e 68       		.byte	0x68
 1653 030f 0A       		.byte	0xa
 1654 0310 6300     		.string	"c"
 1655 0312 01       		.byte	0x1
 1656 0313 31       		.byte	0x31
 1657 0314 0D       		.byte	0xd
 1658 0315 9E000000 		.4byte	0x9e
 1659 0319 02       		.byte	0x2
 1660 031a 91       		.byte	0x91
 1661 031b 64       		.byte	0x64
 1662 031c 0A       		.byte	0xa
 1663 031d 6400     		.string	"d"
 1664 031f 01       		.byte	0x1
 1665 0320 31       		.byte	0x31
 1666 0321 10       		.byte	0x10
 1667 0322 9E000000 		.4byte	0x9e
 1668 0326 02       		.byte	0x2
 1669 0327 91       		.byte	0x91
 1670 0328 60       		.byte	0x60
 1671 0329 0A       		.byte	0xa
 1672 032a 6500     		.string	"e"
 1673 032c 01       		.byte	0x1
 1674 032d 31       		.byte	0x31
 1675 032e 13       		.byte	0x13
 1676 032f 9E000000 		.4byte	0x9e
 1677 0333 02       		.byte	0x2
 1678 0334 91       		.byte	0x91
 1679 0335 5C       		.byte	0x5c
 1680 0336 0A       		.byte	0xa
 1681 0337 6600     		.string	"f"
 1682 0339 01       		.byte	0x1
 1683 033a 31       		.byte	0x31
 1684 033b 16       		.byte	0x16
 1685 033c 9E000000 		.4byte	0x9e
 1686 0340 02       		.byte	0x2
 1687 0341 91       		.byte	0x91
 1688 0342 58       		.byte	0x58
 1689 0343 0A       		.byte	0xa
 1690 0344 6700     		.string	"g"
 1691 0346 01       		.byte	0x1
 1692 0347 31       		.byte	0x31
 1693 0348 19       		.byte	0x19
 1694 0349 9E000000 		.4byte	0x9e
 1695 034d 02       		.byte	0x2
 1696 034e 91       		.byte	0x91
 1697 034f 54       		.byte	0x54
 1698 0350 0A       		.byte	0xa
GAS LISTING /tmp/ccUgdhPb.s 			page 35


 1699 0351 6800     		.string	"h"
 1700 0353 01       		.byte	0x1
 1701 0354 31       		.byte	0x31
 1702 0355 1C       		.byte	0x1c
 1703 0356 9E000000 		.4byte	0x9e
 1704 035a 02       		.byte	0x2
 1705 035b 91       		.byte	0x91
 1706 035c 50       		.byte	0x50
 1707 035d 0A       		.byte	0xa
 1708 035e 6900     		.string	"i"
 1709 0360 01       		.byte	0x1
 1710 0361 31       		.byte	0x31
 1711 0362 1F       		.byte	0x1f
 1712 0363 9E000000 		.4byte	0x9e
 1713 0367 02       		.byte	0x2
 1714 0368 91       		.byte	0x91
 1715 0369 4C       		.byte	0x4c
 1716 036a 0A       		.byte	0xa
 1717 036b 6A00     		.string	"j"
 1718 036d 01       		.byte	0x1
 1719 036e 31       		.byte	0x31
 1720 036f 22       		.byte	0x22
 1721 0370 9E000000 		.4byte	0x9e
 1722 0374 02       		.byte	0x2
 1723 0375 91       		.byte	0x91
 1724 0376 48       		.byte	0x48
 1725 0377 0A       		.byte	0xa
 1726 0378 743100   		.string	"t1"
 1727 037b 01       		.byte	0x1
 1728 037c 31       		.byte	0x31
 1729 037d 25       		.byte	0x25
 1730 037e 9E000000 		.4byte	0x9e
 1731 0382 02       		.byte	0x2
 1732 0383 91       		.byte	0x91
 1733 0384 44       		.byte	0x44
 1734 0385 0A       		.byte	0xa
 1735 0386 743200   		.string	"t2"
 1736 0389 01       		.byte	0x1
 1737 038a 31       		.byte	0x31
 1738 038b 29       		.byte	0x29
 1739 038c 9E000000 		.4byte	0x9e
 1740 0390 02       		.byte	0x2
 1741 0391 91       		.byte	0x91
 1742 0392 40       		.byte	0x40
 1743 0393 0A       		.byte	0xa
 1744 0394 6D00     		.string	"m"
 1745 0396 01       		.byte	0x1
 1746 0397 31       		.byte	0x31
 1747 0398 2D       		.byte	0x2d
 1748 0399 A2030000 		.4byte	0x3a2
 1749 039d 03       		.byte	0x3
 1750 039e 91       		.byte	0x91
 1751 039f C07D     		.byte	0xc0,0x7d
 1752 03a1 00       		.byte	0
 1753 03a2 13       		.byte	0x13
 1754 03a3 9E000000 		.4byte	0x9e
 1755 03a7 09       		.byte	0x9
GAS LISTING /tmp/ccUgdhPb.s 			page 36


 1756 03a8 40000000 		.4byte	0x40
 1757 03ac 3F       		.byte	0x3f
 1758 03ad 00       		.byte	0
 1759 03ae 00       		.byte	0
 1760              		.section	.debug_abbrev,"",@progbits
 1761              	.Ldebug_abbrev0:
 1762 0000 01       		.byte	0x1
 1763 0001 11       		.byte	0x11
 1764 0002 01       		.byte	0x1
 1765 0003 25       		.byte	0x25
 1766 0004 0E       		.byte	0xe
 1767 0005 13       		.byte	0x13
 1768 0006 0B       		.byte	0xb
 1769 0007 03       		.byte	0x3
 1770 0008 0E       		.byte	0xe
 1771 0009 1B       		.byte	0x1b
 1772 000a 0E       		.byte	0xe
 1773 000b 11       		.byte	0x11
 1774 000c 01       		.byte	0x1
 1775 000d 12       		.byte	0x12
 1776 000e 07       		.byte	0x7
 1777 000f 10       		.byte	0x10
 1778 0010 17       		.byte	0x17
 1779 0011 00       		.byte	0
 1780 0012 00       		.byte	0
 1781 0013 02       		.byte	0x2
 1782 0014 24       		.byte	0x24
 1783 0015 00       		.byte	0
 1784 0016 0B       		.byte	0xb
 1785 0017 0B       		.byte	0xb
 1786 0018 3E       		.byte	0x3e
 1787 0019 0B       		.byte	0xb
 1788 001a 03       		.byte	0x3
 1789 001b 0E       		.byte	0xe
 1790 001c 00       		.byte	0
 1791 001d 00       		.byte	0
 1792 001e 03       		.byte	0x3
 1793 001f 16       		.byte	0x16
 1794 0020 00       		.byte	0
 1795 0021 03       		.byte	0x3
 1796 0022 0E       		.byte	0xe
 1797 0023 3A       		.byte	0x3a
 1798 0024 0B       		.byte	0xb
 1799 0025 3B       		.byte	0x3b
 1800 0026 0B       		.byte	0xb
 1801 0027 39       		.byte	0x39
 1802 0028 0B       		.byte	0xb
 1803 0029 49       		.byte	0x49
 1804 002a 13       		.byte	0x13
 1805 002b 00       		.byte	0
 1806 002c 00       		.byte	0
 1807 002d 04       		.byte	0x4
 1808 002e 24       		.byte	0x24
 1809 002f 00       		.byte	0
 1810 0030 0B       		.byte	0xb
 1811 0031 0B       		.byte	0xb
 1812 0032 3E       		.byte	0x3e
GAS LISTING /tmp/ccUgdhPb.s 			page 37


 1813 0033 0B       		.byte	0xb
 1814 0034 03       		.byte	0x3
 1815 0035 08       		.byte	0x8
 1816 0036 00       		.byte	0
 1817 0037 00       		.byte	0
 1818 0038 05       		.byte	0x5
 1819 0039 26       		.byte	0x26
 1820 003a 00       		.byte	0
 1821 003b 49       		.byte	0x49
 1822 003c 13       		.byte	0x13
 1823 003d 00       		.byte	0
 1824 003e 00       		.byte	0
 1825 003f 06       		.byte	0x6
 1826 0040 13       		.byte	0x13
 1827 0041 01       		.byte	0x1
 1828 0042 0B       		.byte	0xb
 1829 0043 0B       		.byte	0xb
 1830 0044 3A       		.byte	0x3a
 1831 0045 0B       		.byte	0xb
 1832 0046 3B       		.byte	0x3b
 1833 0047 0B       		.byte	0xb
 1834 0048 39       		.byte	0x39
 1835 0049 0B       		.byte	0xb
 1836 004a 01       		.byte	0x1
 1837 004b 13       		.byte	0x13
 1838 004c 00       		.byte	0
 1839 004d 00       		.byte	0
 1840 004e 07       		.byte	0x7
 1841 004f 0D       		.byte	0xd
 1842 0050 00       		.byte	0
 1843 0051 03       		.byte	0x3
 1844 0052 0E       		.byte	0xe
 1845 0053 3A       		.byte	0x3a
 1846 0054 0B       		.byte	0xb
 1847 0055 3B       		.byte	0x3b
 1848 0056 0B       		.byte	0xb
 1849 0057 39       		.byte	0x39
 1850 0058 0B       		.byte	0xb
 1851 0059 49       		.byte	0x49
 1852 005a 13       		.byte	0x13
 1853 005b 38       		.byte	0x38
 1854 005c 0B       		.byte	0xb
 1855 005d 00       		.byte	0
 1856 005e 00       		.byte	0
 1857 005f 08       		.byte	0x8
 1858 0060 01       		.byte	0x1
 1859 0061 01       		.byte	0x1
 1860 0062 49       		.byte	0x49
 1861 0063 13       		.byte	0x13
 1862 0064 01       		.byte	0x1
 1863 0065 13       		.byte	0x13
 1864 0066 00       		.byte	0
 1865 0067 00       		.byte	0
 1866 0068 09       		.byte	0x9
 1867 0069 21       		.byte	0x21
 1868 006a 00       		.byte	0
 1869 006b 49       		.byte	0x49
GAS LISTING /tmp/ccUgdhPb.s 			page 38


 1870 006c 13       		.byte	0x13
 1871 006d 2F       		.byte	0x2f
 1872 006e 0B       		.byte	0xb
 1873 006f 00       		.byte	0
 1874 0070 00       		.byte	0
 1875 0071 0A       		.byte	0xa
 1876 0072 34       		.byte	0x34
 1877 0073 00       		.byte	0
 1878 0074 03       		.byte	0x3
 1879 0075 08       		.byte	0x8
 1880 0076 3A       		.byte	0x3a
 1881 0077 0B       		.byte	0xb
 1882 0078 3B       		.byte	0x3b
 1883 0079 0B       		.byte	0xb
 1884 007a 39       		.byte	0x39
 1885 007b 0B       		.byte	0xb
 1886 007c 49       		.byte	0x49
 1887 007d 13       		.byte	0x13
 1888 007e 02       		.byte	0x2
 1889 007f 18       		.byte	0x18
 1890 0080 00       		.byte	0
 1891 0081 00       		.byte	0
 1892 0082 0B       		.byte	0xb
 1893 0083 2E       		.byte	0x2e
 1894 0084 01       		.byte	0x1
 1895 0085 3F       		.byte	0x3f
 1896 0086 19       		.byte	0x19
 1897 0087 03       		.byte	0x3
 1898 0088 0E       		.byte	0xe
 1899 0089 3A       		.byte	0x3a
 1900 008a 0B       		.byte	0xb
 1901 008b 3B       		.byte	0x3b
 1902 008c 0B       		.byte	0xb
 1903 008d 39       		.byte	0x39
 1904 008e 0B       		.byte	0xb
 1905 008f 49       		.byte	0x49
 1906 0090 13       		.byte	0x13
 1907 0091 11       		.byte	0x11
 1908 0092 01       		.byte	0x1
 1909 0093 12       		.byte	0x12
 1910 0094 07       		.byte	0x7
 1911 0095 40       		.byte	0x40
 1912 0096 18       		.byte	0x18
 1913 0097 9642     		.byte	0x96,0x42
 1914 0099 19       		.byte	0x19
 1915 009a 01       		.byte	0x1
 1916 009b 13       		.byte	0x13
 1917 009c 00       		.byte	0
 1918 009d 00       		.byte	0
 1919 009e 0C       		.byte	0xc
 1920 009f 34       		.byte	0x34
 1921 00a0 00       		.byte	0
 1922 00a1 03       		.byte	0x3
 1923 00a2 0E       		.byte	0xe
 1924 00a3 3A       		.byte	0x3a
 1925 00a4 0B       		.byte	0xb
 1926 00a5 3B       		.byte	0x3b
GAS LISTING /tmp/ccUgdhPb.s 			page 39


 1927 00a6 0B       		.byte	0xb
 1928 00a7 39       		.byte	0x39
 1929 00a8 0B       		.byte	0xb
 1930 00a9 49       		.byte	0x49
 1931 00aa 13       		.byte	0x13
 1932 00ab 02       		.byte	0x2
 1933 00ac 18       		.byte	0x18
 1934 00ad 00       		.byte	0
 1935 00ae 00       		.byte	0
 1936 00af 0D       		.byte	0xd
 1937 00b0 0B       		.byte	0xb
 1938 00b1 01       		.byte	0x1
 1939 00b2 11       		.byte	0x11
 1940 00b3 01       		.byte	0x1
 1941 00b4 12       		.byte	0x12
 1942 00b5 07       		.byte	0x7
 1943 00b6 00       		.byte	0
 1944 00b7 00       		.byte	0
 1945 00b8 0E       		.byte	0xe
 1946 00b9 2E       		.byte	0x2e
 1947 00ba 01       		.byte	0x1
 1948 00bb 3F       		.byte	0x3f
 1949 00bc 19       		.byte	0x19
 1950 00bd 03       		.byte	0x3
 1951 00be 0E       		.byte	0xe
 1952 00bf 3A       		.byte	0x3a
 1953 00c0 0B       		.byte	0xb
 1954 00c1 3B       		.byte	0x3b
 1955 00c2 0B       		.byte	0xb
 1956 00c3 39       		.byte	0x39
 1957 00c4 0B       		.byte	0xb
 1958 00c5 27       		.byte	0x27
 1959 00c6 19       		.byte	0x19
 1960 00c7 11       		.byte	0x11
 1961 00c8 01       		.byte	0x1
 1962 00c9 12       		.byte	0x12
 1963 00ca 07       		.byte	0x7
 1964 00cb 40       		.byte	0x40
 1965 00cc 18       		.byte	0x18
 1966 00cd 9642     		.byte	0x96,0x42
 1967 00cf 19       		.byte	0x19
 1968 00d0 01       		.byte	0x1
 1969 00d1 13       		.byte	0x13
 1970 00d2 00       		.byte	0
 1971 00d3 00       		.byte	0
 1972 00d4 0F       		.byte	0xf
 1973 00d5 05       		.byte	0x5
 1974 00d6 00       		.byte	0
 1975 00d7 03       		.byte	0x3
 1976 00d8 08       		.byte	0x8
 1977 00d9 3A       		.byte	0x3a
 1978 00da 0B       		.byte	0xb
 1979 00db 3B       		.byte	0x3b
 1980 00dc 0B       		.byte	0xb
 1981 00dd 39       		.byte	0x39
 1982 00de 0B       		.byte	0xb
 1983 00df 49       		.byte	0x49
GAS LISTING /tmp/ccUgdhPb.s 			page 40


 1984 00e0 13       		.byte	0x13
 1985 00e1 02       		.byte	0x2
 1986 00e2 18       		.byte	0x18
 1987 00e3 00       		.byte	0
 1988 00e4 00       		.byte	0
 1989 00e5 10       		.byte	0x10
 1990 00e6 05       		.byte	0x5
 1991 00e7 00       		.byte	0
 1992 00e8 03       		.byte	0x3
 1993 00e9 0E       		.byte	0xe
 1994 00ea 3A       		.byte	0x3a
 1995 00eb 0B       		.byte	0xb
 1996 00ec 3B       		.byte	0x3b
 1997 00ed 0B       		.byte	0xb
 1998 00ee 39       		.byte	0x39
 1999 00ef 0B       		.byte	0xb
 2000 00f0 49       		.byte	0x49
 2001 00f1 13       		.byte	0x13
 2002 00f2 02       		.byte	0x2
 2003 00f3 18       		.byte	0x18
 2004 00f4 00       		.byte	0
 2005 00f5 00       		.byte	0
 2006 00f6 11       		.byte	0x11
 2007 00f7 0F       		.byte	0xf
 2008 00f8 00       		.byte	0
 2009 00f9 0B       		.byte	0xb
 2010 00fa 0B       		.byte	0xb
 2011 00fb 49       		.byte	0x49
 2012 00fc 13       		.byte	0x13
 2013 00fd 00       		.byte	0
 2014 00fe 00       		.byte	0
 2015 00ff 12       		.byte	0x12
 2016 0100 2E       		.byte	0x2e
 2017 0101 01       		.byte	0x1
 2018 0102 3F       		.byte	0x3f
 2019 0103 19       		.byte	0x19
 2020 0104 03       		.byte	0x3
 2021 0105 0E       		.byte	0xe
 2022 0106 3A       		.byte	0x3a
 2023 0107 0B       		.byte	0xb
 2024 0108 3B       		.byte	0x3b
 2025 0109 0B       		.byte	0xb
 2026 010a 39       		.byte	0x39
 2027 010b 0B       		.byte	0xb
 2028 010c 27       		.byte	0x27
 2029 010d 19       		.byte	0x19
 2030 010e 11       		.byte	0x11
 2031 010f 01       		.byte	0x1
 2032 0110 12       		.byte	0x12
 2033 0111 07       		.byte	0x7
 2034 0112 40       		.byte	0x40
 2035 0113 18       		.byte	0x18
 2036 0114 9742     		.byte	0x97,0x42
 2037 0116 19       		.byte	0x19
 2038 0117 01       		.byte	0x1
 2039 0118 13       		.byte	0x13
 2040 0119 00       		.byte	0
GAS LISTING /tmp/ccUgdhPb.s 			page 41


 2041 011a 00       		.byte	0
 2042 011b 13       		.byte	0x13
 2043 011c 01       		.byte	0x1
 2044 011d 01       		.byte	0x1
 2045 011e 49       		.byte	0x49
 2046 011f 13       		.byte	0x13
 2047 0120 00       		.byte	0
 2048 0121 00       		.byte	0
 2049 0122 00       		.byte	0
 2050              		.section	.debug_aranges,"",@progbits
 2051 0000 2C000000 		.4byte	0x2c
 2052 0004 0200     		.2byte	0x2
 2053 0006 00000000 		.4byte	.Ldebug_info0
 2054 000a 08       		.byte	0x8
 2055 000b 00       		.byte	0
 2056 000c 0000     		.2byte	0
 2057 000e 0000     		.2byte	0
 2058 0010 00000000 		.8byte	.Ltext0
 2058      00000000 
 2059 0018 00000000 		.8byte	.Letext0-.Ltext0
 2059      00000000 
 2060 0020 00000000 		.8byte	0
 2060      00000000 
 2061 0028 00000000 		.8byte	0
 2061      00000000 
 2062              		.section	.debug_line,"",@progbits
 2063              	.Ldebug_line0:
 2064 0000 BF080000 		.section	.debug_str,"MS",@progbits,1
 2064      03006100 
 2064      00000101 
 2064      FB0E0D00 
 2064      01010101 
 2065              	.LASF17:
 2066 0000 73746174 		.string	"state"
 2066      6500
 2067              	.LASF15:
 2068 0006 64617461 		.string	"datalen"
 2068      6C656E00 
 2069              	.LASF13:
 2070 000e 574F5244 		.string	"WORD"
 2070      00
 2071              	.LASF12:
 2072 0013 42595445 		.string	"BYTE"
 2072      00
 2073              	.LASF19:
 2074 0018 74657874 		.string	"text"
 2074      00
 2075              	.LASF26:
 2076 001d 474E5520 		.string	"GNU C17 10.1.0 -mtune=rocket -march=rv64imafdc -mabi=lp64d -g"
 2076      43313720 
 2076      31302E31 
 2076      2E30202D 
 2076      6D74756E 
 2077              	.LASF21:
 2078 005b 73686132 		.string	"sha256_final"
 2078      35365F66 
 2078      696E616C 
GAS LISTING /tmp/ccUgdhPb.s 			page 42


 2078      00
 2079              	.LASF14:
 2080 0068 64617461 		.string	"data"
 2080      00
 2081              	.LASF24:
 2082 006d 73686132 		.string	"sha256_init"
 2082      35365F69 
 2082      6E697400 
 2083              	.LASF6:
 2084 0079 756E7369 		.string	"unsigned char"
 2084      676E6564 
 2084      20636861 
 2084      7200
 2085              	.LASF1:
 2086 0087 6C6F6E67 		.string	"long unsigned int"
 2086      20756E73 
 2086      69676E65 
 2086      6420696E 
 2086      7400
 2087              	.LASF8:
 2088 0099 73686F72 		.string	"short unsigned int"
 2088      7420756E 
 2088      7369676E 
 2088      65642069 
 2088      6E7400
 2089              	.LASF11:
 2090 00ac 73697A65 		.string	"size_t"
 2090      5F7400
 2091              	.LASF16:
 2092 00b3 6269746C 		.string	"bitlen"
 2092      656E00
 2093              	.LASF20:
 2094 00ba 6D61696E 		.string	"main"
 2094      00
 2095              	.LASF18:
 2096 00bf 53484132 		.string	"SHA256_CTX"
 2096      35365F43 
 2096      545800
 2097              	.LASF4:
 2098 00ca 756E7369 		.string	"unsigned int"
 2098      676E6564 
 2098      20696E74 
 2098      00
 2099              	.LASF10:
 2100 00d7 6C6F6E67 		.string	"long long unsigned int"
 2100      206C6F6E 
 2100      6720756E 
 2100      7369676E 
 2100      65642069 
 2101              	.LASF23:
 2102 00ee 73686132 		.string	"sha256_update"
 2102      35365F75 
 2102      70646174 
 2102      6500
 2103              	.LASF22:
 2104 00fc 68617368 		.string	"hash"
 2104      00
GAS LISTING /tmp/ccUgdhPb.s 			page 43


 2105              	.LASF28:
 2106 0101 2F686F6D 		.string	"/home/jasonj2021/Desktop/proj1/sha256"
 2106      652F6A61 
 2106      736F6E6A 
 2106      32303231 
 2106      2F446573 
 2107              	.LASF2:
 2108 0127 6C6F6E67 		.string	"long long int"
 2108      206C6F6E 
 2108      6720696E 
 2108      7400
 2109              	.LASF25:
 2110 0135 73686132 		.string	"sha256_transform"
 2110      35365F74 
 2110      72616E73 
 2110      666F726D 
 2110      00
 2111              	.LASF9:
 2112 0146 63686172 		.string	"char"
 2112      00
 2113              	.LASF7:
 2114 014b 73686F72 		.string	"short int"
 2114      7420696E 
 2114      7400
 2115              	.LASF27:
 2116 0155 73686132 		.string	"sha256.c"
 2116      35362E63 
 2116      00
 2117              	.LASF0:
 2118 015e 6C6F6E67 		.string	"long int"
 2118      20696E74 
 2118      00
 2119              	.LASF3:
 2120 0167 6C6F6E67 		.string	"long double"
 2120      20646F75 
 2120      626C6500 
 2121              	.LASF5:
 2122 0173 7369676E 		.string	"signed char"
 2122      65642063 
 2122      68617200 
 2123              		.ident	"GCC: (GNU) 10.1.0"
