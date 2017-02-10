/**
 * Created by Graffit on 09.02.2017.
 */

public with sharing class People_cHusbandAdderService {


    public void addHusband(List<People__c> peopleList) {

        //list of husbands that need to update at the end
        List<People__c> husbandsToUpdate = new List<People__c>();

        //at first we need to retreive set of husbands ids from peopleList
        Set<Id> husbandsIdSet = getHusbandsSet(peopleList);

        //then we need to get map of that husbands to change their Husband_Wife__c lately
        Map<Id, People__c> husbandsIds = new Map<Id, People__c>([SELECT Husband_Wife__c FROM People__c WHERE Id IN :husbandsIdSet]);

        //for each item in people list we must search his candidate husband in map and set husband.husband to current human id
        for (People__c human : peopleList) {
            if(human.Husband_Wife__c != null) {
                People__c husband = /*[SELECT Name, Husband_Wife__c FROM People__c WHERE Id = :human.Husband_Wife__c LIMIT 1];*/husbandsIds.get(human.Husband_Wife__c);
                husband.Husband_Wife__c = human.Id;

                //collect all records that need to be updated
                husbandsToUpdate.add(husband);
                System.debug('AFTER INSERT: human name:' + human.Name + ' human id:' + human.Id + ' human wife:' + human.Husband_Wife__c);
                System.debug('AFTER INSERT: husband name:' + husband.Name + ' husband id:' + husband.Id + ' husband wife:' + husband.Husband_Wife__c);
            }
        }
        update husbandsToUpdate;
    }

    public void addHusband(List<People__c> newList, Map<Id, People__c> oldMap) {
        List<People__c> peopleList = new List<People__c>();

        for (People__c updateCandidate : newList) {
            if (updateCandidate.Husband_Wife__c != oldMap.get(updateCandidate.Id).Husband_Wife__c) {
                peopleList.add(updateCandidate);
           //     People__c oldHusband = [SELECT Name, Husband_Wife__c FROM People__c WHERE Id = :oldMap.get(updateCandidate.Id).Husband_Wife__c LIMIT 1];
             //   System.debug('OLD HUSBAND');
            //    System.debug(oldHusband);
//                oldHusband.Husband_Wife__c = null;
//                update oldHusband;
            }
        }

        if (peopleList.size() != 0) {
            addHusband(peopleList);
        }
        System.debug('AFTER UPDATE: list size:' + peopleList.size());
        System.debug(peopleList);
    }

    private Set<Id> getHusbandsSet(List<People__c> peopleList) {
        Set<Id> resultSet = new Set<Id>();
        for(People__c human : peopleList) {
            if(human.Husband_Wife__c != null) {
                resultSet.add(human.Husband_Wife__c);
            }
        }
        return resultSet;
    }
}