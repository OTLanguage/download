#!/bin/bash

OTL_HOME="${HOME}/.otl"

case $SHELL in
  "/bin/bash"|"bash")
    ALIAS=~/.bashrc
    ;;
  "/bin/zsh"|"zsh")
    ALIAS=~/.zshrc
    ;;
  *)
    echo "지원하지 않는 Shell 입니다."
    exit 0
    ;;
esac

if [[ `cat $ALIAS` != *'export OTL_HOME'* ]]; then
  echo 'export OTL_HOME="${HOME}/.otl"' >> $ALIAS
  export OTL_HOME="${HOME}/.otl"
fi

cd "${HOME}"

download() {
  if [ -f "${OTL_HOME}/otl" ]; then
    echo "재설치를 위해 삭제합니다."
    rm -rf .otl
  fi  
  git clone https://github.com/OTLanguage/.otl.git  
  MODULE_ZIP="${OTL_HOME}/run-tool/lib/modules.zip"
  unzip "${MODULE_ZIP}" -d "${OTL_HOME}/run-tool/lib"
  if [ -e "${OTL_HOME}/run-tool/lib/modules" ]; then
    rm -f "${MODULE_ZIP}"
  else
    echo "modules 생성에 실패하였습니다."
    exit 0
  fi
  
  if [ -f "${OTL_HOME}/otl" ]; then
    chmod +x "${OTL_HOME}/otl"
    if [[ `cat $ALIAS` != *'alias otl'* ]]; then
      echo 'alias otl="sh ${OTL_HOME}/otl"' >> $ALIAS
      alias otl="sh ${OTL_HOME}/otl"
    fi
    echo "설치가 완료되었습니다. 터미널을 재시작하시면 세팅이 적용됩니다."
  else
    echo "설치에 실패하였습니다."
  fi
}

if [ -d "${OTL_HOME}" ]; then
  if [ -f "${OTL_HOME}/otl" ]; then
    echo "이미 설치되어 있습니다."
    echo "재설치를 시작합니다."
    download
  else
    echo "${OTL_HOME} 경로는 otl에서 사용하는 경로 입니다. 해당 디렉토리를 이름 변경이나 이동해주세요."
  fi
else
  download
fi