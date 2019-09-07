package pljava;

import java.util.*;
public class Moderator {

	
    public Integer[][] mysort(Integer[][] ar) {
        Arrays.sort(ar, new Comparator<Integer[]>() {
            @Override
            public int compare(Integer[] col1, Integer[] col2) {
                Integer numOfKeys1 = col1[1];
                Integer numOfKeys2 = col2[1];
                
                return numOfKeys1.compareTo(numOfKeys2);
            }
        });
        return ar;
    }
}


