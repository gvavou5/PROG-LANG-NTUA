//package myReader;
import java.util.Scanner;
import java.io.* ;
import java.lang.Math.* ;


public class Reader2{
	public  int N;
	public  long M;
	public  int i,j,k;
	public  long sum,min,max,mid;
	public  double ret;
	public  long [] [] array;
	public Scanner scanner;

	public Reader2(File arg){		
		try{
			scanner = new Scanner(arg);
			N = scanner.nextInt();
			array = new long [N][4];
			array[0][0] = scanner.nextInt()*1000;
			array[0][1] = scanner.nextInt()*1000;
			array[0][2] = scanner.nextInt();
			array[0][3] = scanner.nextInt();
			min = array[0][0];
			max = array[0][0]+array[0][1];
			for(i = 1; i < N; i++){
				array[i][0] = scanner.nextInt()*1000L;
				array[i][1] = scanner.nextInt()*1000;
				array[i][2] = scanner.nextInt();
				array[i][3] = scanner.nextInt();
				if (min > array[i][0]) min = array[i][0];
				if (max < array[i][0]+array[i][1]) max = array[i][0]+array[i][1];
			}
			M = scanner.nextLong()*1000L;
		
		}
		catch (Exception e){
		}

	}

	public long[][] getArray(){				
		return array;
	}
	public int getN(){
		return N;
	}
	public long getM(){
		return M;
	}
	public long getMin(){
		return min;
	}
	public long getMax(){
		return max;
	}
	
}
