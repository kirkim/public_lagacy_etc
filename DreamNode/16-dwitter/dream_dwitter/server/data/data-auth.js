let auths = [];

export async function findByusername(username) {
  return auths.find((auth) => auth.username === username);
}

export async function findById(id) {
  return auths.find((auth) => auth.id === id);
}

export async function create(user) {
  const auth = { id: Date.now().toString(), ...user };
  auths = [auth, ...auths];
  return auth.id;
}
