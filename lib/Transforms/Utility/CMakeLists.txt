add_llvm_library(LLVMUtility
	LogFunctionNames.cpp
  )

add_dependencies(LLVMUtility intrinsics_gen)
