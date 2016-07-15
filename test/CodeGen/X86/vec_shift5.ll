; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown -mattr=+sse2 | FileCheck %s --check-prefix=X32
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+sse2 | FileCheck %s --check-prefix=X64

; Verify that we correctly fold target specific packed vector shifts by
; immediate count into a simple build_vector when the elements of the vector
; in input to the packed shift are all constants or undef.

define <8 x i16> @test1() {
; X32-LABEL: test1:
; X32:       # BB#0:
; X32-NEXT:    movaps {{.*#+}} xmm0 = [8,16,32,64,8,16,32,64]
; X32-NEXT:    retl
;
; X64-LABEL: test1:
; X64:       # BB#0:
; X64-NEXT:    movaps {{.*#+}} xmm0 = [8,16,32,64,8,16,32,64]
; X64-NEXT:    retq
  %1 = tail call <8 x i16> @llvm.x86.sse2.pslli.w(<8 x i16> <i16 1, i16 2, i16 4, i16 8, i16 1, i16 2, i16 4, i16 8>, i32 3)
  ret <8 x i16> %1
}

define <8 x i16> @test2() {
; X32-LABEL: test2:
; X32:       # BB#0:
; X32-NEXT:    movaps {{.*#+}} xmm0 = [0,1,2,4,0,1,2,4]
; X32-NEXT:    retl
;
; X64-LABEL: test2:
; X64:       # BB#0:
; X64-NEXT:    movaps {{.*#+}} xmm0 = [0,1,2,4,0,1,2,4]
; X64-NEXT:    retq
  %1 = tail call <8 x i16> @llvm.x86.sse2.psrli.w(<8 x i16> <i16 4, i16 8, i16 16, i16 32, i16 4, i16 8, i16 16, i16 32>, i32 3)
  ret <8 x i16> %1
}

define <8 x i16> @test3() {
; X32-LABEL: test3:
; X32:       # BB#0:
; X32-NEXT:    movaps {{.*#+}} xmm0 = [0,1,2,4,0,1,2,4]
; X32-NEXT:    retl
;
; X64-LABEL: test3:
; X64:       # BB#0:
; X64-NEXT:    movaps {{.*#+}} xmm0 = [0,1,2,4,0,1,2,4]
; X64-NEXT:    retq
  %1 = tail call <8 x i16> @llvm.x86.sse2.psrai.w(<8 x i16> <i16 4, i16 8, i16 16, i16 32, i16 4, i16 8, i16 16, i16 32>, i32 3)
  ret <8 x i16> %1
}

define <4 x i32> @test4() {
; X32-LABEL: test4:
; X32:       # BB#0:
; X32-NEXT:    movaps {{.*#+}} xmm0 = [8,16,32,64]
; X32-NEXT:    retl
;
; X64-LABEL: test4:
; X64:       # BB#0:
; X64-NEXT:    movaps {{.*#+}} xmm0 = [8,16,32,64]
; X64-NEXT:    retq
  %1 = tail call <4 x i32> @llvm.x86.sse2.pslli.d(<4 x i32> <i32 1, i32 2, i32 4, i32 8>, i32 3)
  ret <4 x i32> %1
}

define <4 x i32> @test5() {
; X32-LABEL: test5:
; X32:       # BB#0:
; X32-NEXT:    movaps {{.*#+}} xmm0 = [0,1,2,4]
; X32-NEXT:    retl
;
; X64-LABEL: test5:
; X64:       # BB#0:
; X64-NEXT:    movaps {{.*#+}} xmm0 = [0,1,2,4]
; X64-NEXT:    retq
  %1 = tail call <4 x i32> @llvm.x86.sse2.psrli.d(<4 x i32> <i32 4, i32 8, i32 16, i32 32>, i32 3)
  ret <4 x i32> %1
}

define <4 x i32> @test6() {
; X32-LABEL: test6:
; X32:       # BB#0:
; X32-NEXT:    movaps {{.*#+}} xmm0 = [0,1,2,4]
; X32-NEXT:    retl
;
; X64-LABEL: test6:
; X64:       # BB#0:
; X64-NEXT:    movaps {{.*#+}} xmm0 = [0,1,2,4]
; X64-NEXT:    retq
  %1 = tail call <4 x i32> @llvm.x86.sse2.psrai.d(<4 x i32> <i32 4, i32 8, i32 16, i32 32>, i32 3)
  ret <4 x i32> %1
}

define <2 x i64> @test7() {
; X32-LABEL: test7:
; X32:       # BB#0:
; X32-NEXT:    movdqa {{.*#+}} xmm0 = [1,0,2,0]
; X32-NEXT:    psllq $3, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test7:
; X64:       # BB#0:
; X64-NEXT:    movaps {{.*#+}} xmm0 = [8,16]
; X64-NEXT:    retq
  %1 = tail call <2 x i64> @llvm.x86.sse2.pslli.q(<2 x i64> <i64 1, i64 2>, i32 3)
  ret <2 x i64> %1
}

define <2 x i64> @test8() {
; X32-LABEL: test8:
; X32:       # BB#0:
; X32-NEXT:    movdqa {{.*#+}} xmm0 = [8,0,16,0]
; X32-NEXT:    psrlq $3, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test8:
; X64:       # BB#0:
; X64-NEXT:    movaps {{.*#+}} xmm0 = [1,2]
; X64-NEXT:    retq
  %1 = tail call <2 x i64> @llvm.x86.sse2.psrli.q(<2 x i64> <i64 8, i64 16>, i32 3)
  ret <2 x i64> %1
}

define <8 x i16> @test9() {
; X32-LABEL: test9:
; X32:       # BB#0:
; X32-NEXT:    movaps {{.*#+}} xmm0 = <1,1,u,u,3,u,8,16>
; X32-NEXT:    retl
;
; X64-LABEL: test9:
; X64:       # BB#0:
; X64-NEXT:    movaps {{.*#+}} xmm0 = <1,1,u,u,3,u,8,16>
; X64-NEXT:    retq
  %1 = tail call <8 x i16> @llvm.x86.sse2.psrai.w(<8 x i16> <i16 15, i16 8, i16 undef, i16 undef, i16 31, i16 undef, i16 64, i16 128>, i32 3)
  ret <8 x i16> %1
}

define <4 x i32> @test10() {
; X32-LABEL: test10:
; X32:       # BB#0:
; X32-NEXT:    movaps {{.*#+}} xmm0 = <u,1,u,4>
; X32-NEXT:    retl
;
; X64-LABEL: test10:
; X64:       # BB#0:
; X64-NEXT:    movaps {{.*#+}} xmm0 = <u,1,u,4>
; X64-NEXT:    retq
  %1 = tail call <4 x i32> @llvm.x86.sse2.psrai.d(<4 x i32> <i32 undef, i32 8, i32 undef, i32 32>, i32 3)
  ret <4 x i32> %1
}

define <2 x i64> @test11() {
; X32-LABEL: test11:
; X32:       # BB#0:
; X32-NEXT:    movdqa {{.*#+}} xmm0 = <u,u,31,0>
; X32-NEXT:    psrlq $3, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test11:
; X64:       # BB#0:
; X64-NEXT:    movaps {{.*#+}} xmm0 = <u,3>
; X64-NEXT:    retq
  %1 = tail call <2 x i64> @llvm.x86.sse2.psrli.q(<2 x i64> <i64 undef, i64 31>, i32 3)
  ret <2 x i64> %1
}

define <8 x i16> @test12() {
; X32-LABEL: test12:
; X32:       # BB#0:
; X32-NEXT:    movaps {{.*#+}} xmm0 = <1,1,u,u,3,u,8,16>
; X32-NEXT:    retl
;
; X64-LABEL: test12:
; X64:       # BB#0:
; X64-NEXT:    movaps {{.*#+}} xmm0 = <1,1,u,u,3,u,8,16>
; X64-NEXT:    retq
  %1 = tail call <8 x i16> @llvm.x86.sse2.psrai.w(<8 x i16> <i16 15, i16 8, i16 undef, i16 undef, i16 31, i16 undef, i16 64, i16 128>, i32 3)
  ret <8 x i16> %1
}

define <4 x i32> @test13() {
; X32-LABEL: test13:
; X32:       # BB#0:
; X32-NEXT:    movaps {{.*#+}} xmm0 = <u,1,u,4>
; X32-NEXT:    retl
;
; X64-LABEL: test13:
; X64:       # BB#0:
; X64-NEXT:    movaps {{.*#+}} xmm0 = <u,1,u,4>
; X64-NEXT:    retq
  %1 = tail call <4 x i32> @llvm.x86.sse2.psrli.d(<4 x i32> <i32 undef, i32 8, i32 undef, i32 32>, i32 3)
  ret <4 x i32> %1
}

define <8 x i16> @test14() {
; X32-LABEL: test14:
; X32:       # BB#0:
; X32-NEXT:    movaps {{.*#+}} xmm0 = <1,1,u,u,3,u,8,16>
; X32-NEXT:    retl
;
; X64-LABEL: test14:
; X64:       # BB#0:
; X64-NEXT:    movaps {{.*#+}} xmm0 = <1,1,u,u,3,u,8,16>
; X64-NEXT:    retq
  %1 = tail call <8 x i16> @llvm.x86.sse2.psrli.w(<8 x i16> <i16 15, i16 8, i16 undef, i16 undef, i16 31, i16 undef, i16 64, i16 128>, i32 3)
  ret <8 x i16> %1
}

define <4 x i32> @test15() {
; X32-LABEL: test15:
; X32:       # BB#0:
; X32-NEXT:    movaps {{.*#+}} xmm0 = <u,64,u,256>
; X32-NEXT:    retl
;
; X64-LABEL: test15:
; X64:       # BB#0:
; X64-NEXT:    movaps {{.*#+}} xmm0 = <u,64,u,256>
; X64-NEXT:    retq
  %1 = tail call <4 x i32> @llvm.x86.sse2.pslli.d(<4 x i32> <i32 undef, i32 8, i32 undef, i32 32>, i32 3)
  ret <4 x i32> %1
}

define <2 x i64> @test16() {
; X32-LABEL: test16:
; X32:       # BB#0:
; X32-NEXT:    movdqa {{.*#+}} xmm0 = <u,u,31,0>
; X32-NEXT:    psllq $3, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test16:
; X64:       # BB#0:
; X64-NEXT:    movaps {{.*#+}} xmm0 = <u,248>
; X64-NEXT:    retq
  %1 = tail call <2 x i64> @llvm.x86.sse2.pslli.q(<2 x i64> <i64 undef, i64 31>, i32 3)
  ret <2 x i64> %1
}

declare <8 x i16> @llvm.x86.sse2.pslli.w(<8 x i16>, i32)
declare <8 x i16> @llvm.x86.sse2.psrli.w(<8 x i16>, i32)
declare <8 x i16> @llvm.x86.sse2.psrai.w(<8 x i16>, i32)
declare <4 x i32> @llvm.x86.sse2.pslli.d(<4 x i32>, i32)
declare <4 x i32> @llvm.x86.sse2.psrli.d(<4 x i32>, i32)
declare <4 x i32> @llvm.x86.sse2.psrai.d(<4 x i32>, i32)
declare <2 x i64> @llvm.x86.sse2.pslli.q(<2 x i64>, i32)
declare <2 x i64> @llvm.x86.sse2.psrli.q(<2 x i64>, i32)

