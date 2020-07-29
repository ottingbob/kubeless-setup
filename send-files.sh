#!/bin/sh

SEND_FILE () {
  # Gather args && shift
  FILE=$1
  shift;
  
  # Validate the file
  if [ ! -f "$FILE" ]; then
    printf "$FILE not found. We are skipping...\n"
    return
  fi

  # Any extra args
  EXTRA_ARGS=$@

  # Setup vars
  USER=<user>
  HOST=<ip_addr>  

  # Check if the FILE arg includes a filepath and make the filepath before
  # copying over the file for l33t strats 

  # Move the weight
  echo "Copying file $FILE to $HOST..."
  cat $FILE | ssh $USER@$HOST "cat > /root/kubeless-example/$FILE"
  echo "Copied file successfully!"
}

ARGS=( "$@" )
echo "Found ${#ARGS[@]} args:"

for i in "${ARGS[@]}"
do
  # printf "$i\n"
  SEND_FILE $i
done

