import { useUserStore } from "@/stores/user";

import guanliyuan from "./guanliyuan";
import yisheng from "./yisheng";
import yonghu from "./yonghu";

export function getMenus() {
    return new Promise((resolve, reject) => {
        var userStore = useUserStore();
        var cx = userStore.getSession("cx");
        if (cx == "管理员") {
            resolve(guanliyuan);
        }
        if (cx == "医生") {
            resolve(yisheng);
        }
        if (cx == "用户") {
            resolve(yonghu);
        }
    });
}

export default {
    getMenus,
};
