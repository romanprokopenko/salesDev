/**
 * Created by Graffit on 09.02.2017.
 */

public with sharing class People_cTriggerHandler {
//  service variable
    private People_cHusbandAdderService husbandAdderService = new People_cHusbandAdderService();


    public void afterInsert(List<People__c> newList, Map<Id, People__c> newMap){
        husbandAdderService.addHusband(newList);
    }

    public void afterUpdate(List<People__c> newList, Map<Id, People__c> newMap, Map<Id, People__c> oldMap){
        husbandAdderService.addHusband(newList, oldMap);
    }

}