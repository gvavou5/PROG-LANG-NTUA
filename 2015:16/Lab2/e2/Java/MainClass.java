package pljava;

public class MainClass {
	public static int mhkos;

	public static void main(String[] args){
		
		ReadClass r = new ReadClass();
		r.openFile();		
		Integer [][] building_status=new Integer [mhkos][6];
		building_status=r.readFile();
		

		r.closeFile();
		Moderator modobject = new Moderator();
		building_status =modobject.mysort(building_status);
	
		int [][] height = new int [1000000][2];
		int count_buildings=0;
	   for(int i=0;i<mhkos-1;i++){
			for(int j=building_status[i][0]; j<=building_status[i][3];j++){
				int fs=1;
				if(height[j][0]<=building_status[i][4] && height[j][1]<building_status[i][5])
				{
					if (fs == 1){
						count_buildings++;
						fs=0;
					}
					height[i][0]=building_status[i][4];
					height[i][1]=building_status[i][5];
				}
			}
		}
 System.out.println(count_buildings);
	}
}
