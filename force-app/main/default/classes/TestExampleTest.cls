@isTest
public with sharing class TestExampleTest {
  @isTest
  public static void testExample_updateAnnualRevenue() {
    Account testAccount = new Account(Name = 'test Account');
    insert testAccount;
    List<Opportunity> opps = new List<Opportunity>();
    Opportunity opp1 = new Opportunity(
      Name = 'Test Opp1',
      StageName = 'Prospecting',
      CloseDate = Date.today(),
      AccountId = testAccount.Id,
      Amount = 1000
    );
    //  insert opp1;
    Opportunity opp2 = new Opportunity(
      Name = 'Test Opp2',
      StageName = 'Prospecting',
      CloseDate = Date.today(),
      AccountId = testAccount.Id,
      Amount = 1000
    );
    //  insert opp2;
    Opportunity opp3 = new Opportunity(
      Name = 'Test Opp3',
      StageName = 'Prospecting',
      CloseDate = Date.today(),
      AccountId = testAccount.Id,
      Amount = 1000
    );

    // insert new List<Opportunity>{opp1,opp2};
    opps.add(opp1);
    opps.add(opp2);
    opps.add(opp3);
    insert opps;

    TestExample tstEx = new TestExample();
    tstEx.updateAnnualRevenue(opps);
    Account updatedAccount = [
      SELECT Id, AnnualRevenue
      FROM Account
      WHERE Id = :testAccount.Id
    ];
    System.debug(
      'Updated Account AnnualRevenue' + updatedAccount.AnnualRevenue
    );
    System.debug(updatedAccount.AnnualRevenue == 3000);
    Assert.isNotNull(
      updatedAccount.AnnualRevenue,
      'This doesnt seem to be null'
    );
    Assert.areEqual(
      3000,
      updatedAccount.AnnualRevenue,
      'AnnualRevenue does seem to match'
    );
  }

  @Istest
  public static void TestExample_updateAccountDescription() {
    Account acc1 = new Account(
      Name = 'Test Account 1',
      Description = 'Test Description 1'
    );
    Account acc2 = new Account(
      Name = 'Test Account 2',
      Description = 'Test Description 2'
    );
    Account acc3 = new Account(
      Name = 'Test Account 1',
      Description = 'Test Description 3'
    );
    insert new List<Account>{ acc1, acc2, acc3 };
    Set<Id> accIds = new Set<Id>{ acc1.Id, acc2.Id, acc3.Id };
    TestExample.updateAccountDescription(accIds);

    TestExample.updateAccountDescription(accIds);

    List<Account> updatedAccounts = [
      SELECT Description
      FROM Account
      WHERE Id IN :accIds
    ];

    for (Account acc : updatedAccounts) {
      System.debug(acc.Description);
      Assert.areEqual(
        'Updated',
        acc.Description,
        'The account description has been updated.'
      );
    }
  }
}
