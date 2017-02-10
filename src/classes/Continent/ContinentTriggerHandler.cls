/**
 * Created by Graffit on 10.02.2017.
 */

public with sharing class ContinentTriggerHandler {

    ContinentHierarchyAdderService hierarchyAdderService = new ContinentHierarchyAdderService();

    public void afterInsert(List<Continent__c> newList) {
        hierarchyAdderService.addHierarchyNameToCountries(newList);
    }

    public void afterUpdate(List<Continent__c> newList, Map<Id, Continent__c> oldMap) {
        System.debug('Continent triggerHandlerAfterUpdate');
        hierarchyAdderService.addHierarchyNameToCountries(newList, oldMap);
    }
}