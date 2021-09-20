class ObjectUtilities {
  /* Your magic here */
  static mergeObjects = (objA, objB) => ({ ...objA, ...objB });
  static removePassword = (obj) => {
    delete obj.password;
    return obj;
  };
  static freezeObj = (obj) => Object.freeze(obj);
  static getOnlyValues = (obj) => Object.keys(obj);
  static getOnlyProperties = (obj) => Object.values(obj);
}

const objA = {
  name: "Nicolas",
  favFood: "Kimchi",
};

const objB = {
  password: "12345",
};

const user = ObjectUtilities.mergeObjects(objA, objB);
console.log(user);

const cleanUser = ObjectUtilities.removePassword(user);
console.log(cleanUser);

const frozenUser = ObjectUtilities.freezeObj(cleanUser);

const onlyValues = ObjectUtilities.getOnlyValues(frozenUser);
console.log(onlyValues);

const onlyProperties = ObjectUtilities.getOnlyProperties(frozenUser);
console.log(onlyProperties);

frozenUser.name = "Hello!"; // This should show an error
console.log(frozenUser);
