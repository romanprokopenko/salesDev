/**
 * Created by Graffit on 10.02.2017.
 */

trigger ContinentTrigger on Continent__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    ContinentTriggerHandler triggerHandler = new ContinentTriggerHandler();
    System.debug('Continent trigger started');
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            triggerHandler.afterInsert(Trigger.new);
        } else if (Trigger.isUpdate) {
            System.debug('Continent trigger afterUpdate');
            triggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
    System.debug('Continent trigger finished');
}