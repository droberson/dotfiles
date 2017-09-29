# quick decoder for base64

b64decode () {
  echo "$1" | base64 -d
}

