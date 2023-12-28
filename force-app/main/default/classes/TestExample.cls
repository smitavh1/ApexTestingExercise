public with sharing class TestExample {
  //Update the AnnualRevenue field on Account from the Sum of all Opportunities
  public void updateAnnualRevenue(List<Opportunity> opps) {
    Double totalAmount = 0.0;
    Id accountId = null;

    for (Opportunity opp : opps) {
      totalAmount = totalAmount + opp.Amount;
      accountId = opp.AccountId;
    }
    //fghgffgf
    Account accountToUpdate = new Account(
      Id = accountId,
      AnnualRevenue = totalAmount
    );
    update accountToUpdate;
  }

  //Gets the list of AccountIds. queries the accounts and updates their description and updates them

  @TestVisible
  private static void updateAccountDescription(Set<Id> accountIds) {
    List<Account> accsToUpdate = [
      SELECT Id, Description
      FROM Account
      WHERE Id IN :accountIds
    ];

    for (Account acc : accsToUpdate) {
      acc.Description = 'Updated';
    }
    update accsToUpdate;
  }
}
