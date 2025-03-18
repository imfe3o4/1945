<template>
    <div class="views-liuyanban-web-add">
        <div>
            <e-container>
                <el-card class="box-card">
                    <template #header>
                        <div class="clearfix">
                            <span class="title"> 添加留言板 </span>
                        </div>
                    </template>

                    <el-form :model="form" ref="formModel" :label-width="labelWidth" status-icon validate-on-rule-change>
                        <el-form-item v-if="isRead" label="账号" prop="zhanghao"> {{ form.zhanghao }} </el-form-item>

                        <el-form-item v-if="isRead" label="姓名" prop="xingming"> {{ form.xingming }} </el-form-item>

                        <el-form-item label="咨询人姓名" prop="zixunrenxingming" required :rules="[{required:true, message:'请填写咨询人姓名'}]">
                            <el-input type="text" placeholder="输入咨询人姓名" style="width: 450px" v-model="form.zixunrenxingming" />
                        </el-form-item>

                        <el-form-item label="联系电话" prop="lianxidianhua" required :rules="[{required:true, message:'请填写联系电话'}]">
                            <el-input type="text" placeholder="输入联系电话" style="width: 450px" v-model="form.lianxidianhua" />
                        </el-form-item>

                        <el-form-item label="留言内容" prop="liuyanneirong" required :rules="[{required:true, message:'请填写留言内容'}]">
                            <el-input type="textarea" v-model="form.liuyanneirong"></el-input>
                        </el-form-item>

                        <el-form-item label="留言人" prop="liuyanren"> <el-input v-model="form.liuyanren" readonly style="width: 250px"></el-input> </el-form-item>

                        <el-form-item v-if="btnText">
                            <el-button type="primary" @click="submit">{{ btnText }}</el-button>
                        </el-form-item>
                    </el-form></el-card
                >
            </e-container>
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
    import { useLiuyanbanCreateForm, canLiuyanbanInsert } from "@/module";

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
    const { form, readMap } = useLiuyanbanCreateForm(props.id);
    const emit = defineEmits(["success"]);
    const formModel = ref();
    const loading = ref(false);
    var submit = () => {
        return new Promise((resolve, reject) => {
            formModel.value
                .validate()
                .then((res) => {
                    if (loading.value) return;
                    loading.value = true;
                    canLiuyanbanInsert(form).then(
                        (res) => {
                            loading.value = false;
                            if (res.code == 0) {
                                emit("success", res.data);
                                if (props.isHouxu) {
                                    ElMessage.success("添加成功");
                                    router.go(-1);
                                }
                            } else {
                                ElMessageBox.alert(res.msg);
                            }
                            resolve(res);
                        },
                        (err) => {
                            loading.value = false;
                            ElMessageBox.alert(err.message);
                            reject(err);
                        }
                    );
                })
                .catch((err) => {
                    reject(err);
                });
        });
    };
</script>

<style scoped lang="scss">
    .views-liuyanban-web-add {
    }
</style>
