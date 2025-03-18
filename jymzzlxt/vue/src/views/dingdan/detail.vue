<template>
    <div class="views-dingdan-detail">
        <div>
            <el-card class="box-card">
                <template #header>
                    <div class="clearfix">
                        <span class="title"> 订单详情 </span>
                    </div>
                </template>

                <div id="printdetail">
                    <el-descriptions class="margin-top" :column="3" border>
                        <el-descriptions-item label="订单号"> {{ map.dingdanhao }} </el-descriptions-item>
                        <el-descriptions-item label="订单金额"> {{ map.dingdanjine }} </el-descriptions-item>
                        <el-descriptions-item label="收货信息">
                            <p>收货人：{{ map.shouhuoren }}</p>
                            <p>手机：{{ map.shouji }}</p>
                            <p>地址：{{ map.dizhi }}</p>
                        </el-descriptions-item>
                        <el-descriptions-item label="收货人"> {{ map.shouhuoren }} </el-descriptions-item>
                        <el-descriptions-item label="手机"> {{ map.shouji }} </el-descriptions-item>
                        <el-descriptions-item label="地址"> {{ map.dizhi }} </el-descriptions-item>
                        <el-descriptions-item label="状态"> {{ map.zhuangtai }} </el-descriptions-item>
                        <el-descriptions-item label="下单人"> {{ map.xiadanren }} </el-descriptions-item>
                        <el-descriptions-item label="添加时间"> {{ map.addtime }} </el-descriptions-item>
                    </el-descriptions>

                    <el-descriptions direction="vertical" class="margin-top" :column="1" border>
                        <el-descriptions-item label="商品">
                            <div id="dataListshangpin" style="text-align: left">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>编号</th>
                                            <th>名称</th>
                                            <th>分类</th>
                                            <th>价格</th>
                                            <th>购买数</th>
                                            <th>小计</th>
                                            <th>购买人</th>
                                            <th>图片</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="dataMap in dataSets">
                                            <td>{{ dataMap.bianhao }}</td>
                                            <td>{{ dataMap.mingcheng }}</td>
                                            <td><e-select-view module="leibie" :value="dataMap.fenlei" select="id" show="leibiemingcheng"></e-select-view></td>
                                            <td>{{ dataMap.jiage }}</td>
                                            <td>{{ dataMap.goumaishu }}</td>
                                            <td>{{ dataMap.xiaoji }}</td>
                                            <td>{{ dataMap.goumairen }}</td>
                                            <td>
                                                <div style="width: 100%; max-width: 120px">
                                                    <e-img :src="dataMap.tupian" type="list"></e-img>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </el-descriptions-item>
                        <el-descriptions-item label="备注"> {{ map.beizhu }} </el-descriptions-item>
                    </el-descriptions>
                </div>
                <div class="no-print" v-if="isShowBtn">
                    <el-button @click="$router.go(-1)">返回</el-button>
                    <el-button @click="$print('#printdetail')">打印</el-button>
                </div>
            </el-card>
        </div>
    </div>
</template>

<script setup>
    import http from "@/utils/ajax/http";
    import DB from "@/utils/db";

    import { ref, reactive, watch, computed } from "vue";
    import { useRoute } from "vue-router";
    import { session } from "@/utils/utils";
    import { extend } from "@/utils/extend";
    import { useDingdanFindById, canDingdanFindById } from "@/module";

    const route = useRoute();
    const props = defineProps({
        id: {
            type: [Number, String],
        },
        isShowBtn: {
            type: Boolean,
            default: true,
        },
    });

    // 获取详情页面的一行数据,当url参数id变更时，自动
    const map = useDingdanFindById(props.id);
    // 当url参数id变更时，自动更新map中的数据
    watch(
        () => props.id,
        (id) => {
            canDingdanFindById(id).then((res) => {
                extend(map, res);
            });
        }
    );
    // end 获取详情页面的一行数据

    const dataSets = DB.name("dingdanshangpin").where("dingdanid", route.query.id).order("id asc").selectRef();
</script>

<style scoped lang="scss">
    .views-dingdan-detail {
    }
</style>
