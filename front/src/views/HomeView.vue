<script setup lang="ts">
import { ref } from "vue";

const areas = ["北海道", "東北", "関東", "中部", "近畿", "中国", "四国", "九州"];

const prefectures = ref({});
const getPrefectures = async (area: string) => {
  const response = await fetch(`http://geoapi.heartrails.com/api/json?method=getPrefectures&area=${area}`, {
    method: "GET",
  });
  const json = await response.json();
  prefectures.value = json.response.prefecture;
};

const cities = ref([]);
const getCities = async (prefecture: string) => {
  const response = await fetch(
    `http://geoapi.heartrails.com/api/json?method=getCities&prefecture=${prefecture}`,
    {
      method: "GET",
    }
  );
  const json = await response.json();
  cities.value = json.response.location.map((loc) => loc.city);
};

const selectedPrefecture = ref("");
const selectPrefecure = (prefecture: string) => {
  selectedPrefecture.value = prefecture;
}

const selectedCity = ref("");
const selectCity = (city: string) => {
  selectedCity.value = city;
}
</script>

<template>
  <div>
    <div>
      <h1>安心して介護をお願いしたいから。</h1>
      <h6>ホームケアナビは、ケアマネージャーの検索ができるサービスです。</h6>
      <input placeholder="事業所名、市区町村など" />
    </div>

    <h2>エリアから探す</h2>
    <div class="flex justify-between">
      <div class="grid grid-rows-4 grid-cols-3 w-1/3">
        <button class="col-span-3">現在地から探す</button>
        <!-- <button>関東</button>
        <button>関西</button>
        <button>東海</button>
        <button>北海道</button>
        <button>東北</button>
        <button>甲信越<br>北陸</button>
        <button>中国</button>
        <button>四国</button>
        <button>九州<br>沖縄</button> -->
        <button v-for="area in areas" :key="area" @click="getPrefectures(area)">
          {{ area }}
        </button>
      </div>
      <div class="border-solid border-2 border-gray-300 w-1/3">
        <ul>
          <li
            v-for="prefecture in prefectures"
            :key="prefecture"
            @click="getCities(prefecture)"
            class="cursor-pointer hover:bg-blue-300"
          >
            {{ prefecture }}
          </li>
        </ul>
      </div>
      <div class="border-solid border-2 border-gray-300 w-1/3 h-96 overflow-y-scroll">
        <ul>
          <li v-for="city in cities" :key="city" class="hover:bg-blue-300">
            <label class="cursor-pointer">
              <input type="checkbox" :value="city" />
              {{ city }}
            </label>
          </li>
        </ul>
        <button>クリア</button>
        <button>検索する</button>
      </div>
    </div>
  </div>
</template>
