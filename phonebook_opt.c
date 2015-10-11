#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "phonebook_opt.h"

/* FILL YOUR OWN IMPLEMENTATION HERE! */
entry *findName(char *key, hashtable *ht)
{
    /* TODO: implement */
	entry *e;
	int index = hash(ht,key);
	for(e = ht->table[index]; e != NULL; e = e->pNext){
		if(strcasecmp(key,e->lastName)==0){
			return e;
		}
	}
    return NULL;
}

entry *append(char *key, hashtable *ht)
{
	int index = hash( ht, key );
	entry *newentry;
	newentry = (entry *)malloc(sizeof(entry));
	if(newentry == NULL){
		puts("make new entry failed!");
		return NULL;
	}

	strcpy(newentry->lastName, key);
	newentry->pNext = ht->table[index];
	ht->table[index] = newentry;
    return 0;
}

hashtable *create(int size){
	hashtable *ht = NULL;
	/* check size  */
	if(size < 1) {
		return NULL;
	}
	/* allocate the table itself  */
	if((ht = (hashtable *)malloc(sizeof(hashtable))) == NULL){
		return NULL;
	} 
	/* allocate pointers to the table */
	if((ht->table = malloc(sizeof(entry *)* size )) == NULL){
		return NULL;	
	}
	ht->size = size;
	return ht;
}
int hash(hashtable *ht, char *key){
	unsigned int hashVal = 0;
	while(*key != '\0'){
		hashVal = (hashVal << 5) + *key++;
	}
	return hashVal % ht->size;
}
