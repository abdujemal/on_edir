class BankAccountOption {
  String bank, account;
  BankAccountOption(this.bank, this.account);

  Map<String, Object> toFirebaseMap(BankAccountOption option) {
    return {"bank": option.bank, "account": option.account};
  }

  BankAccountOption.fromFirebase(Map<dynamic, dynamic> data)
      : bank = data["bank"],
        account = data["account"];
}
