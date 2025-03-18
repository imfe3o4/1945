<template>
    <div class="views-shijuan-updt">
        <div>
            <el-card class="box-card">
                <template #header>
                    <div class="clearfix">
                        <span class="title"> 添加试卷 </span>
                    </div>
                </template>

                <el-form :model="form" ref="formModel" :label-width="labelWidth" status-icon validate-on-rule-change>
                    <el-form-item label="试卷编号" prop="shijuanbianhao" :rules="[{required:true, message:'请填写试卷编号'}]">
                        <el-input type="text" placeholder="输入试卷编号" style="width: 450px" v-model="form.shijuanbianhao" />
                    </el-form-item>

                    <el-form-item label="试卷名称" prop="shijuanmingcheng" required :rules="[{required:true, message:'请填写试卷名称'}]">
                        <el-input type="text" placeholder="输入试卷名称" style="width: 450px" v-model="form.shijuanmingcheng" />
                    </el-form-item>

                    <el-form-item label="答题类型" prop="datileixing" required :rules="[{required:true, message:'请填写答题类型'}]">
                        <el-select v-model="form.datileixing"
                            ><el-option label="每日答题" value="每日答题"></el-option>
                            <el-option label="健康自测" value="健康自测"></el-option>
                        </el-select>
                    </el-form-item>

                    <el-form-item label="图片" prop="tupian" required :rules="[{required:true, message:'请填写图片'}]">
                        <e-upload-image v-model="form.tupian" is-paste></e-upload-image>
                    </el-form-item>

                    <el-form-item label="时长" prop="shichang" required :rules="[{required:true, message:'请填写时长'}]">
                        <el-input type="text" placeholder="输入时长" style="width: 450px" v-model="form.shichang" />
                    </el-form-item>

                    <el-form-item label="试卷简介" prop="shijuanjianjie">
                        <el-input type="text" placeholder="输入试卷简介" style="width: 450px" v-model="form.shijuanjianjie" />
                    </el-form-item>

                    <el-form-item label="发布人" prop="faburen"> <el-input v-model="form.faburen" readonly style="width: 250px"></el-input> </el-form-item>

                    <el-form-item v-if="btnText">
                        <el-button type="primary" @click="submit">{{ btnText }}</el-button>
                    </el-form-item>
                </el-form></el-card
            >
        </div>
    </div>
</template>

<script setup>
    import http from "@/utils/ajax/http";
    import DB from "@/utils/db";
    import rule from "@/utils/rule";
    import router from "@/router";

    import { ref, reactive, computed } from "vue";
    import { useRoute } from "vue-router";
    import { session } from "@/utils/utils";
    import { ElMessage, ElMessageBox } from "element-plus";
    import { useShijuanFindById, canShijuanFindById, canShijuanUpdate } from "@/module";

    const route = useRoute();
    const props = defineProps({
        id: [String, Number],
        btnText: {
            type: String,
            default: "保存",
        },
        isRead: {
            type: Boolean,
            default: true,
        },
        isHouxu: {
            type: Boolean,
            default: true,
        },
        labelWidth: {
            type: String,
            default: "140px",
        },
    });
    const form = useShijuanFindById(props.id);
    const emit = defineEmits(["success"]);
    const formModel = ref();
    const loading = ref(false);

    const submit = () => {
        formModel.value.validate().then((res) => {
            if (loading.value) return;
            loading.value = true;
            canShijuanUpdate(form).then(
                (res) => {
                    loading.value = false;
                    if (res.code == 0) {
                        emit("success", res.data);
                        if (props.isHouxu) {
                            ElMessage.success("更新成功");
                            router.go(-1);
                        }
                    } else {
                        ElMessageBox.alert(res.msg);
                    }
                },
                (err) => {
                    loading.value = false;
                    ElMessageBox.alert(err.message);
                }
            );
        });
    };
</script>

<style scoped lang="scss">
    .views-shijuan-updt {
    }
</style>
