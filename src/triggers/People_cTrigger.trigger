/**
 * Created by Graffit on 09.02.2017.
 */

trigger People_cTrigger on People__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    People_cTriggerHandler peopleHandler = new People_cTriggerHandler();
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            peopleHandler.afterInsert(Trigger.new, Trigger.newMap);
        } else if (Trigger.isUpdate) {
            peopleHandler.afterUpdate(Trigger.new, Trigger.newMap, Trigger.oldMap);
        }
    }
}