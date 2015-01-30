
public class prog4252 {

	public static void main(String args[]){
		String Phrases[]= {"abcdefghijklmnopqrstuvwxyz\0", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdeabcdeABCDEXYXYXYZz\0",
		"1234567890-=`~!@#$%^&*()_+[]\\{}|';:,./?><\0"};

		int[] counter= new int[26];
		int phraseCounter=0;
		while(phraseCounter < Phrases.length){
			int n=0;
			char c= Phrases[phraseCounter].charAt(n);
			while(c != 0){
				if(c >= 65){
					if(c <= 90){
					counter[c-65]+=1;
					}
				}
				 
				if(c >= 97 && c <= 122)
					counter[c-97]+=1;
				
				n++;
				c= Phrases[phraseCounter].charAt(n);
			}
			System.out.println(Phrases[phraseCounter]);
			int z=0;
			while(z<26){
				int a=  z+97;
				System.out.println( (char)a + ":" +"\t"+ counter[z]+"");
				z++;
			}
			phraseCounter++;
		}

	}
}
