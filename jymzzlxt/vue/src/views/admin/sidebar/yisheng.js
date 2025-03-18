export default [
    {
        label: "排班管理",
        to: "",
        children: [
            {
                label: "排班查询",
                to: { path: "/admin/paiban/zhanghao" },
            },
        ],
    },
    {
        label: "预约挂号管理",
        to: "",
        children: [
            {
                label: "预约挂号查询",
                to: { path: "/admin/yuyueguahao/zhanghao" },
            },
        ],
    },
    {
        label: "个性心理诊疗方案",
        to: "",
        children: [
            {
                label: "心理诊疗方案查询",
                to: { path: "/admin/xinlizhenliaofangan/zhanghao" },
            },
        ],
    },
    {
        label: "文章/建议",
        to: "",
        children: [
            {
                label: "文章添加",
                to: { path: "/admin/wenzhang/add" },
            },
            {
                label: "文章查询",
                to: { path: "/admin/wenzhang/tianjiaren" },
            },
        ],
    },
    {
        label: "留言管理",
        to: "",
        children: [
            {
                label: "留言查询",
                to: { path: "/admin/liuyanban/zhanghao" },
            },
        ],
    },
    {
        label: "个人信息",
        to: "",
        children: [
            {
                label: "修改个人资料",
                to: { path: "/admin/yisheng/updtself" },
            },
            {
                label: "修改密码",
                to: { path: "/admin/mod" },
            },
        ],
    },
];
