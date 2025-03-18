<template>
    <div class="views-zhuye">
        <div>
            <e-container>
                <el-carousel indicator-position="outside" height="420px">
                    <el-carousel-item v-for="item in bhtList" :key="item.id">
                        <a href="javascript:;">
                            <div
                                style="background-size: cover"
                                @click="$goto(item.url)"
                                :style="{'background-image': 'url('+$formatImageSrc(item.image)+')',width:'100%', height: '420px'}"
                            ></div>
                        </a>
                    </el-carousel-item>
                </el-carousel>
            </e-container>
        </div>
        <div>
            <e-container>
                <div class="title-sn-title1">
                    <div class="sn-title">
                        <span> 医生 </span>
                    </div>
                    <div class="sn-content">
                        <div class="snick clearfix">
                            <el-row>
                                <el-col class="snock" v-for="r in yishenglist" :md="6">
                                    <div class="services">
                                        <router-link :to="'/yisheng/detail?id='+r.id">
                                            <e-img :src="r.zhaopian" class="snocks"></e-img>
                                            <h2 v-html="$substr(r.xingming,15)"></h2>
                                            <p v-html="$substr(r.jianjie,30)"></p>
                                        </router-link>
                                    </div>
                                </el-col>
                            </el-row>
                        </div>
                    </div>
                </div>
            </e-container>
        </div>
        <div>
            <e-container>
                <div class="title-sn-title1">
                    <div class="sn-title">
                        <span> 文章 </span>
                    </div>
                    <div class="sn-content">
                        <div class="snick clearfix">
                            <el-row>
                                <el-col class="snock" v-for="r in wenzhanglist" :md="6">
                                    <div class="services">
                                        <router-link :to="'/wenzhang/detail?id='+r.id">
                                            <e-img :src="r.tupian" class="snocks"></e-img>
                                            <h2 v-html="$substr(r.biaoti,15)"></h2>
                                            <p v-html="$substr(r.xiangqing,30)"></p>
                                        </router-link>
                                    </div>
                                </el-col>
                            </el-row>
                        </div>
                    </div>
                </div>
            </e-container>
        </div>
        <div>
            <e-container>
                <div class="title-sn-title1">
                    <div class="sn-title">
                        <span> 药品 </span>
                    </div>
                    <div class="sn-content">
                        <el-row :gutter="30">
                            <el-col v-for="r in yaopinlist" :md="6" :key="r.id" style="margin-bottom: 20px">
                                <article class="single_product v-module-xiezi">
                                    <figure>
                                        <div class="product_thumb" @click="$goto('/yaopin/detail?id='+r.id)">
                                            <div class="label_product"></div>
                                            <e-img class="primary_img" :src="r.tupian" pb="100" :is-scale="false" />
                                        </div>
                                        <figcaption class="product_content">
                                            <h4 class="product_name"><a href="javascript:;" @click="$goto('/yaopin/detail?id='+r.id)"> {{ r.mingcheng }}</a></h4>
                                            <div class="price_box">
                                                <span class="current_price" v-if="r.jiage">￥{{ r.jiage }}</span>
                                            </div>
                                            <div class="add_to_cart">
                                                <a href="javascript:;" title="查看详情" @click="$goto('/yaopin/detail?id='+r.id)">查看详情</a>
                                            </div>
                                        </figcaption>
                                    </figure>
                                </article>
                            </el-col>
                        </el-row>
                    </div>
                </div>
            </e-container>
        </div>
    </div>
</template>

<script setup>
    import http from "@/utils/ajax/http";
    import DB from "@/utils/db";

    import { ref, reactive } from "vue";
    import { useRoute } from "vue-router";
    import { session } from "@/utils/utils";

    const route = useRoute();
    // 获取轮播图信息
    const bhtList = DB.name("lunbotu").order("id desc").limit(5).selectRef();

    // 定义响应式变量yishenglist,并获取数据医生模块的数据
    const yishenglist = DB.name("yisheng").limit("8").order("id desc").selectRef();

    // 定义响应式变量wenzhanglist,并获取数据文章模块的数据
    const wenzhanglist = DB.name("wenzhang").limit("4").order("id desc").selectRef();

    // 定义响应式变量yaopinlist,并获取数据药品模块的数据
    const yaopinlist = DB.name("yaopin").limit("4").order("id desc").selectRef();
</script>

<style scoped lang="scss">
    .views-zhuye {
    }
</style>
