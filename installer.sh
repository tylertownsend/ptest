#!/bin/bash

PROGRAM="bopeep.sh"
PROGRAM_NAME="bopeep"
FILES_TO_COPY="${PROGRAM} utils.sh"

if [[ $EUID -ne 0 ]]; then
   echo "Please run this script with root privileges." 
   exit 1
fi

function sleeping() {
  sleep .5;
}

echo "Running the ${PROGRAM_NAME} installer"
echo ""
sleeping

# Create the folder to store the folder
DESTINATION="/opt/${PROGRAM_NAME}"
mkdir -p ${DESTINATION}
cp -r ${FILES_TO_COPY} ${DESTINATION}

if [[ "$OSTYPE" == "darwin"* ]]; then
  bash_prof_str="alias bopeep='bash $DESTINATION/$PRORAM'"
  echo "" >> ~/.bash_profile
  echo "# Added by bopeep installer." >> ~/.bash_profiles
  echo $bash_prof_str >> ~/.bash_profile
  source ~/.bash_profile
else
  # Make the files
  EXECUTABLE=${PROGRAM_NAME}
  touch ${EXECUTABLE}

  [ -e "/usr/bin${EXECUTABLE}" ] && rm "$/usr/bin/{EXECUTABLE}"
  echo "#!/bin/bash" >> ${EXECUTABLE}
  echo "bash ${DESTINATION}/${PROGRAM} "'$1' >> ${EXECUTABLE}
  chmod +x ${EXECUTABLE}
  mv ${EXECUTABLE} /usr/bin
fi

echo "Installer finished!"
