
class User {
  account?: string;
  pwd?: string;

  constructor(account: string, pwd: string) {
    this.account = account;
    this.pwd = pwd;
  }
}


class UserDTO extends User {
  token: string = '';

  constructor(id: string, name: string) {
    super(id, name);
  }
}


class Index {
}