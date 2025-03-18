<template>
    <div class="views-yonghu-updtself">
        <div>
            <el-card class="box-card">
                <template #header>
                    <div class="clearfix">
                        <span class="title"> 添加用户 </span>
                    </div>
                </template>

                <el-form :model="form" ref="formModel" :label-width="labelWidth" status-icon validate-on-rule-change>
                    <el-form-item
                        label="账号"
                        prop="zhanghao"
                        required
                        :rules="[{required:true, message:'请填写账号'}, {validator:rule.checkRemote, message:'内容重复了', checktype:'update', module:'yonghu', col:'zhanghao', id:form.id, trigger:'blur'}]"
                    >
                        <el-input type="text" placeholder="输入账号" style="width: 450px" v-model="form.zhanghao" />
                    </el-form-item>

                    <el-form-item label="姓名" prop="xingming" required :rules="[{required:true, message:'请填写姓名'}]">
                        <el-input type="text" placeholder="输入姓名" style="width: 450px" v-model="form.xingming" />
                    </el-form-item>

                    <el-form-item label="性别" prop="xingbie" required :rules="[{required:true, message:'请填写性别'}]">
                        <el-select v-model="form.xingbie"
                            ><el-option label="男" value="男"></el-option>
                            <el-option label="女" value="女"></el-option>
                        </el-select>
                    </el-form-item>

                    <el-form-item label="手机" prop="shouji" required :rules="[{required:true, message:'请填写手机'}, {validator:rule.checkPhone, message:'请输入正确手机号码'}]">
                        <el-input type="text" placeholder="输入手机" style="width: 450px" v-model="form.shouji" />
                    </el-form-item>

                    <el-form-item label="身份证号" prop="shenfenzhenghao" required :rules="[{required:true, message:'请填写身份证号'}]">
                        <el-input type="text" placeholder="输入身份证号" style="width: 450px" v-model="form.shenfenzhenghao" />
                    </el-form-item>

                    <el-form-item label="身高" prop="shengao" required :rules="[{required:true, message:'请填写身高'}]">
                        <el-input type="text" placeholder="输入身高" style="width: 450px" v-model="form.shengao" />
                    </el-form-item>

                    <el-form-item label="体重" prop="tizhong" required :rules="[{required:true, message:'请填写体重'}]">
                        <el-input type="text" placeholder="输入体重" style="width: 450px" v-model="form.tizhong" />
                    </el-form-item>

                    <el-form-item label="婚姻状况" prop="hunyinzhuangkuang" required :rules="[{required:true, message:'请填写婚姻状况'}]">
                        <el-select v-model="form.hunyinzhuangkuang"
                            ><el-option label="未婚" value="未婚"></el-option>
                            <el-option label="已婚" value="已婚"></el-option>
                        </el-select>
                    </el-form-item>

                    <el-form-item label="民族" prop="minzu" required :rules="[{required:true, message:'请填写民族'}]">
                        <el-input type="text" placeholder="输入民族" style="width: 450px" v-model="form.minzu" />
                    </el-form-item>

                    <el-form-item label="现病史" prop="xianbingshi" required :rules="[{required:true, message:'请填写现病史'}]">
                        <el-input type="text" placeholder="输入现病史" style="width: 450px" v-model="form.xianbingshi" />
                    </el-form-item>

                    <el-form-item label="既往病史" prop="jiwangbingshi" required :rules="[{required:true, message:'请填写既往病史'}]">
                        <el-input type="text" placeholder="输入既往病史" style="width: 450px" v-model="form.jiwangbingshi" />
                    </el-form-item>

                    <el-form-item label="家族病史" prop="jiazubingshi" required :rules="[{required:true, message:'请填写家族病史'}]">
                        <el-input type="text" placeholder="输入家族病史" style="width: 450px" v-model="form.jiazubingshi" />
                    </el-form-item>

                    <el-form-item label="头像" prop="touxiang"> <e-upload-image v-model="form.touxiang" is-paste></e-upload-image> </el-form-item>

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
    import { useYonghuFindById, canYonghuFindById, canYonghuUpdate } from "@/module";

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
    const form = useYonghuFindById(props.id);
    const emit = defineEmits(["success"]);
    const formModel = ref();
    const loading = ref(false);

    const submit = () => {
        formModel.value.validate().then((res) => {
            if (loading.value) return;
            loading.value = true;
            canYonghuUpdate(form).then(
                (res) => {
                    loading.value = false;
                    if (res.code == 0) {
                        emit("success", res.data);
                        if (props.isHouxu) {
                            ElMessage.success("更新成功");
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
    .views-yonghu-updtself {
    }
</style>
