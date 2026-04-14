const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const config = require("../config");

const users = [];

exports.register = async ({ username, password, role }) => {
  const existed = users.find((u) => u.username === username);
  if (existed) {
    throw { status: 400, message: "Username da ton tai" };
  }

  const hashedPassword = await bcrypt.hash(password, 10);

  const newUser = {
    id: users.length + 1,
    username,
    password: hashedPassword,
    role: role || "viewer",
  };
  users.push(newUser);

  return { userId: newUser.id };
};

exports.login = async ({ username, password }) => {
  const user = users.find((u) => u.username === username);
  if (!user) {
    throw { status: 401, message: "Sai username hoac password" };
  }

  const valid = await bcrypt.compare(password, user.password);
  if (!valid) {
    throw { status: 401, message: "Sai username hoac password" };
  }

  const token = jwt.sign(
    { id: user.id, username: user.username, role: user.role },
    config.jwtSecret,
    { expiresIn: "24h" }
  );

  return { token, user: { id: user.id, username: user.username, role: user.role } };
};
