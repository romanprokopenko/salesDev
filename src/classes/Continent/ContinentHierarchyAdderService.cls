/**
 * Created by Graffit on 10.02.2017.
 */

public with sharing class ContinentHierarchyAdderService {

    public void addHierarchyNameToCountries(List<Continent__c> continents){
        List<Country__c> countriesToUpdate = new List<Country__c>();
        for (Continent__c continent : continents) {
            List<Country__c> countriesOnContinent = [SELECT Name, Hierarchy_name__c FROM Country__c WHERE Continent__c = :continent.Id];
            System.debug('CURRENT CONTINENT:' + continent.Name);
            System.debug('CURRENT CONTINENT COUNTRIES:' + countriesOnContinent);
            for (Country__c country : countriesOnContinent) {
                country.Hierarchy_name__c = continent.Name + ' ' + country.Name;
                System.debug('COUNTRY NEW HIERARCHY NAME:' + country.Hierarchy_name__c);
                countriesToUpdate.add(country);
            }
        }
        update countriesToUpdate;
    }

    public void addHierarchyNameToCountries(List<Continent__c> newContinents, Map<Id, Continent__c> oldContinentsByIds) {
        System.debug('Continent service after update');
        List<Continent__c> continentsToUpdate = new List<Continent__c>();
        for (Continent__c continent : newContinents) {
            if (!continent.Name.equals(oldContinentsByIds.get(continent.Id).Name)) {
                continentsToUpdate.add(continent);
                System.debug('continent added to updateList:' + continent);
            }
        }

        addHierarchyNameToCountries(continentsToUpdate);
    }
}