#!/bin/sh

# shellcheck disable=SC2164,SC2034
cd "${HOME}"
dir_check="${HOME}/.otl"
file_check="${HOME}/.otl/otl"

download() {
    rm -rf .otl
    git clone https://github.com/OTLanguage/.otl.git
    chmod +x "${HOME}/.otl/otl"
    # shellcheck disable=SC2006
    file=`cat ~/.zshrc`
    zs_value=alias otl="sh ${HOME}/.otl/otl"
    # shellcheck disable=SC2039,SC2081
    if [ "${file}" != *"${zs_value}"* ]; then
      # shellcheck disable=SC2016
      echo 'alias otl="sh ${HOME}/.otl/otl"' >>  ~/.zshrc
    fi
    echo "설치가 완료되었습니다. 터미널을 재시작하시면 세팅이 적용됩니다."
}

if [ -d "$dir_check" ]; then
  if [ -f "$file_check" ]; then
    echo "이미 설치되어 있습니다."
      echo "1) 최신 버전으로 재설치"
      echo "2) 취소"
      # shellcheck disable=SC2162
      read menu
      # shellcheck disable=SC2039
      if [ "$menu" == 1 ]; then
        download
      else
        exit 0
      fi
  else
    echo "${HOME}/.otl 경로는 otl에서 사용하는 경로 입니다. 해당 디렉토리를 이름 변경이나 이동해주세요."
  fi
else
  download
fi