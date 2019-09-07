package pljava;
import java.io.File;
import java.util.*;

public class ReadClass {
	
		private Scanner x;
		public void openFile(){
			try 
			{
				x=new Scanner(new File ("C:\\test\\java2test.txt"));
			}
			catch(Exception e)
			{
			System.out.println("could not find file");
			}
		}
		
		
		public Integer[][] readFile(){
			int len=x.nextInt();
			MainClass.mhkos=len;
			Integer [][] pin =new Integer[len][6];
			int help=0;
			while (len>0){				
				pin[len-1][help]=x.nextInt();
				help++;
				pin[len-1][help]=x.nextInt();
				help++;
				pin[len-1][help]=x.nextInt();
				help++;
				pin[len-1][help]=x.nextInt();
				help++;
				double helper=x.nextDouble();
				String numberStr = Double.toString(helper);
				String fractionalStr = numberStr.substring(numberStr.indexOf('.')+1);
				int fractional = Integer.valueOf(fractionalStr);
				pin[len-1][help]=(int) (helper);
				help++;
				pin[len-1][help]=Integer.valueOf(fractional);
				len--;
				help=0;
			}
			return pin;
		}
		
		
		
		public void closeFile(){
			x.close();
		}
	}

