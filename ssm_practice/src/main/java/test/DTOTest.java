package test;


import org.junit.Test;
import top.gn.ssm.dto.BaseResult;

public class DTOTest {

    @Test
    public void dtoTest(){
        BaseResult baseResult = BaseResult.success()
                .addShowField("alis", "vxcfds")
                .addShowField("name", "小李")
                .addShowField("age", 20);
        System.out.println(baseResult.getData());
    }

    @Test
    public void tempTest(){
        System.out.println("11111111111111111111111".matches("^[1-9]{1,10}$"));
    }

}
