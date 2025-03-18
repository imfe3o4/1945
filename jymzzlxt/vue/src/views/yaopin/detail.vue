<template>
    <div class="views-yaopin-detail">
        <div>
            <el-card class="box-card">
                <template #header>
                    <div class="clearfix">
                        <span class="title"> 药品详情 </span>
                    </div>
                </template>

                <div id="printdetail">
                    <el-descriptions class="margin-top" :column="3" border>
                        <el-descriptions-item label="编号"> {{ map.bianhao }} </el-descriptions-item>
                        <el-descriptions-item label="名称"> {{ map.mingcheng }} </el-descriptions-item>
                        <el-descriptions-item label="分类">
                            <e-select-view module="leibie" :value="map.fenlei" select="id" show="leibiemingcheng"></e-select-view>
                        </el-descriptions-item>
                        <el-descriptions-item label="价格"> {{ map.jiage }} </el-descriptions-item>
                        <el-descriptions-item label="库存"> {{ map.kucun }} </el-descriptions-item>
                        <el-descriptions-item label="销量"> {{ map.xiaoliang }} </el-descriptions-item>
                        <el-descriptions-item label="添加人"> {{ map.tianjiaren }} </el-descriptions-item>
                    </el-descriptions>

                    <el-descriptions direction="vertical" class="margin-top" :column="1" border>
                        <el-descriptions-item label="图片"> <e-images :src="map.tupian" type="detail"></e-images> </el-descriptions-item>
                        <el-descriptions-item label="药品详情"> <div v-html="map.yaopinxiangqing"></div> </el-descriptions-item>
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
    import { useYaopinFindById, canYaopinFindById } from "@/module";

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
    const map = useYaopinFindById(props.id);
    // 当url参数id变更时，自动更新map中的数据
    watch(
        () => props.id,
        (id) => {
            canYaopinFindById(id).then((res) => {
                extend(map, res);
            });
        }
    );
    // end 获取详情页面的一行数据
</script>

<style scoped lang="scss">
    .views-yaopin-detail {
    }
</style>
