#!/bin/bash

# shellcheck disable=SC2164,SC2034
cd "${HOME}"
dir_check="${HOME}/.otl"
file_check="${HOME}/.otl/otl"
download_version="$1"
echo $0
echo $1
echo $2

download() {
    echo "재설치를 위해 삭제합니다."
    rm -rf .otl
    if [ -z "$download_version" ]; then
      git clone https://github.com/OTLanguage/.otl.git
      module_zip="${HOME}/.otl/run-tool/lib/modules.zip"
      unzip "${module_zip}" -d "${HOME}/.otl/run-tool/lib"
      if [ -e "${HOME}/.otl/run-tool/lib/modules" ]; then
        rm -f "${module_zip}"
      else
        echo "modules 생성에 실패하였습니다."
        exit 0
      fi
    else
      if [[ $download_version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        git clone -b "$download_version" --single-branch https://github.com/OTLanguage/.otl.git
      else
          echo "버전 형태가 일치하지 않습니다."
          exit 0
      fi
    fi

    if [ -f "${HOME}/.otl/otl" ]; then
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
    else
      echo "설치에 실패하였습니다."
    fi
}

if [ -d "$dir_check" ]; then
  if [ -f "$file_check" ]; then
    echo "이미 설치되어 있습니다."
    echo "재설치를 시작합니다."
    download
  else
    echo "${HOME}/.otl 경로는 otl에서 사용하는 경로 입니다. 해당 디렉토리를 이름 변경이나 이동해주세요."
  fi
else
  download
fi
