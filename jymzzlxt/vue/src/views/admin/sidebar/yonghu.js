export default [
    {
        label: "预约挂号管理",
        to: "",
        children: [
            {
                label: "预约挂号查询",
                to: { path: "/admin/yuyueguahao/guahaoren" },
            },
        ],
    },
    {
        label: "个性心理诊疗方案",
        to: "",
        children: [
            {
                label: "心理诊疗方案查询",
                to: { path: "/admin/xinlizhenliaofangan/guahaoren" },
            },
        ],
    },
    {
        label: "答题结果管理",
        to: "",
        children: [
            {
                label: "答题结果查询",
                to: { path: "/admin/jieguo/datiren" },
            },
        ],
    },
    {
        label: "答题成绩",
        to: "",
        children: [
            {
                label: "成绩查询",
                to: { path: "/admin/chengji/datiren" },
            },
        ],
    },
    {
        label: "留言管理",
        to: "",
        children: [
            {
                label: "留言板查询",
                to: { path: "/admin/liuyanban/liuyanren" },
            },
        ],
    },
    {
        label: "通知管理",
        to: "",
        children: [
            {
                label: "通知查询",
                to: { path: "/admin/tongzhi/zhanghao" },
            },
        ],
    },
    {
        label: "个人健康数据管理",
        to: "",
        children: [
            {
                label: "个人健康数据添加",
                to: { path: "/admin/gerenjiankangshuju/add" },
            },
            {
                label: "个人健康数据查询",
                to: { path: "/admin/gerenjiankangshuju/yonghu" },
            },
        ],
    },
    {
        label: "收货地址管理",
        to: "",
        children: [
            {
                label: "收货地址添加",
                to: { path: "/admin/shouhuodizhi/add" },
            },
            {
                label: "收货地址查询",
                to: { path: "/admin/shouhuodizhi" },
            },
        ],
    },
    {
        label: "订单管理",
        to: "",
        children: [
            {
                label: "订单查询",
                to: { path: "/admin/dingdan/xiadanren" },
            },
        ],
    },
    {
        label: "个人信息",
        to: "",
        children: [
            {
                label: "修改个人资料",
                to: { path: "/admin/yonghu/updtself" },
            },
            {
                label: "修改密码",
                to: { path: "/admin/mod" },
            },
        ],
    },
];
