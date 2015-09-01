#include<stdio.h>
#include<string.h>
#include<stdlib.h>

enum Boolean{ false, true };

int main( ){

	FILE *ifp = fopen("/home/sherlock/Downloads/ExonIntronData.txt","r");
	FILE *ofp = fopen("/home/sherlock/pract/modEIData.txt","w") ;
    enum Boolean newline = false;
    
	char str [100000];
	int c, ch;

	if( ifp == NULL ) perror("Error opening input file\n");
	if( ofp == NULL ) perror("Error opening output file\n");

	else{

		while( ( c = fgetc(ifp) ) != EOF ){
			if( c == '>' ){
			// ignore the line starting with >
				while( ( ch = fgetc( ifp ) ) != '\n' );
				if( newline == false )
				    newline = true;
				else
    				fputc( '\n', ofp );
			}
			if( c == '\n' || c == '>');
            else
    			fputc( c, ofp );

		}

		fclose( ifp );
		fclose( ofp );

	}

	return 0;
	
}
