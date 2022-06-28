//Function to Parse nested object based on the keys
function nestedObjParser(object, key) {
  for (let k of key.split('/')) {
    if (object[k] !== undefined) {
      object = object[k];
    }
  }
  return object;
}

let obj = { x: { y: { z: 'a' } } };
console.log(nestedObjParser(obj, 'x/y/z'));
