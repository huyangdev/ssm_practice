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

}
