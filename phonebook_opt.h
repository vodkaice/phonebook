#ifndef _PHONEBOOK_H
#define _PHONEBOOK_H

#define MAX_LAST_NAME_SIZE 16

/* original version */
typedef struct __PHONE_BOOK_ENTRY {
    char lastName[MAX_LAST_NAME_SIZE];
    char firstName[16];
    char email[16];
    char phone[10];
    char cell[10];
    char addr1[16];
    char addr2[16];
    char city[16];
    char state[2];
    char zip[5];
    struct __PHONE_BOOK_ENTRY *pNext;
} entry;

typedef struct hashtable {
    int size;
    struct entry **table;
} hashtable;

entry *findName(char *key, hashtable *ht);
entry *append(char *key, hashtable *ht);
hashtable *createTable(int size);
int hash(hashtable *hashtable, char *key);

#endif
