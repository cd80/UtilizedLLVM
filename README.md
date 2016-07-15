# Utilized LLVM


이 Git은 LLVM에 대한 이해를 돕기 위해 [블로그](http://cd80.tistory.com/category/%EC%BB%B4%ED%93%A8%ED%84%B0%EA%B3%B5%EB%B6%80/%EC%97%98%EC%97%98%EB%B9%84%EC%97%A0)에 설명한 개념들과 코드 스니펫을 통합하기 위해 만들었습니다. 
프로젝트는 Ubuntu 15.10 64비트버젼에서 진행하고 LLVM 3.9.0에서 시작합니다. 업데이트 시 API에 약간 변동이 생기기 때문에(예를 들어 ConstantExpr::getGetElementPtr의 인자가 달라지는 등), 업데이트 시에  모듈을 포팅했을 때 생기는 문제들을 해결하는 과정도 소개할 예정입니다.

제 환경을 그대로 따라오셔서 사용하시면 많은 골치아픈 문제들을 대부분 제 블로그에서 설명할것이기 때문에 큰 문제가 생기지 않겠지만, 자기가 원하는 환경을 구축해 몇가지 문제를 만나보면서 직접 해결해보는것도 큰 도움이 될 것 같습니다. 본인 상황에 맞게 유연하게 적용하시길 바랍니다

This git is to help better understanding of LLVM development with step-by-step explanation in my [blog](http://cd80.tistory.com/category/%EC%BB%B4%ED%93%A8%ED%84%B0%EA%B3%B5%EB%B6%80/%EC%97%98%EC%97%98%EB%B9%84%EC%97%A0). The contents in my blog will be written only in korean, but if anyone wants more detailed explanation in english, i will be very willing to answer any questions.

So, the project will start with LLVM 3.9.0 on Ubuntu 15.10 x64, and we will port our modules when newer version of LLVM is released because their API changes quite a lot per updates(ex. changes in function arguments for ConstantExpr::getGetElementPtr). 

I recommend both, following my OS and LLVM versions to avoid any compatibility issues that are not explained in my tutorial.

Or you can use your own and friendly environment and face some weird problems, this will help you to think more.


##Updates
#####2016.07.15
1. 정리 시작 및 LLVM 최신 버젼 업로드
1. Started project with uploading latest version of LLVM