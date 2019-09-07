import java.util.Scanner;
import java.io.* ;
import java.lang.Math.* ;
//import myReader.Reader2;

public class Deksamenes {

	public static int N;
	public static long M;
	public static long [][] array = new long [N][4] ;
	public static long sum, min, max, mid;
	public static int i, j, k;
	public static Reader2 reader ;	

	public static void main(String[] args){
		try{			
			reader = new Reader2(new File(args[0]));
			N = reader.getN();
			min = reader.getMin();
			max = reader.getMax();			
			M = reader.getM();
			array = reader.getArray();
			
			double ret;
			sum = 0L;
			//System.out.println(array[0][0]);
			for(i = 0; i < N; i++){
				if (array[i][0]+array[i][1] > array[i][0]) {
					if (array[i][0]+array[i][1] < array[i][0]+array[i][1]) 
						sum = sum+(array[i][0]+array[i][1]-array[i][0])*array[i][2]*array[i][3];
					else 
						sum = sum+array[i][1]*array[i][2]*array[i][3];
				}
			}
			
			if (sum > M) {
				mid = (max+min)/2;
				while(min != max){
					sum = 0L;
					for(i = 0; i < N; i++){
						if (mid > array[i][0]) {				
							if (mid < array[i][0]+array[i][1]) 
								sum += (mid-array[i][0]) * array[i][2] * array[i][3];
							else 
								sum += array[i][1]*array[i][2]*array[i][3];
						}
					}		
					if (sum >= M) max = mid;
					else min = mid+1;
					mid = (max+min)/2;
				}
				ret = (double)mid;
				ret = ret/10;
				ret = Math.round(ret);
				ret = ret/100;
				System.out.println(ret);
			}
			else {
				System.out.println("Overflow");
			}
		}
		catch (Exception e){
		}
	}
}
