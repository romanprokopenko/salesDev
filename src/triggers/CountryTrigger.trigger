/**
 * Created by Graffit on 10.02.2017.
 */

trigger CountryTrigger on Country__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {

        } else if (Trigger.isUpdate) {

        }
    }
}