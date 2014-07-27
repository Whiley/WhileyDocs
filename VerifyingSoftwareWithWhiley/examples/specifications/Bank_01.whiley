type Account is {
  int balance,
  int overdraft // limit for how much can be overdrawn
} where balance >= -overdraft

function deposit(int amount, Account account) => Account
requires amount >= 0:
    return {
        balance: account.balance + amount,
        overdraft: account.overdraft
    }

function cashOut(int amount, Account account) => Account
requires account.balance + account.overdraft >= amount:
    //
    return {
        balance: account.balance - amount,
        overdraft: account.overdraft
    }
    
    