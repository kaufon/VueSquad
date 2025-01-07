<template>
  <div v-if="squad">
    <MembersTable :members="squad.users" />
  </div>
  <div v-else>
    <LoaderIcon class="animate-spin w-full " />
  </div>
</template>

<script setup lang="ts">
import { useApi } from '@/ui/hooks';
import MembersTable from './members-table/MembersTable.vue';
import { LoaderIcon } from 'lucide-vue-next';
import { ref } from 'vue';
import type { SquadDto } from '@/@core';
import { useRoute } from 'vue-router';
import router from '@/app/router';
const route = useRoute()
const { squadService } = useApi()
const squad = ref<SquadDto>()
const fetchSquad = async () => {
  const response = await squadService.findById(route.params.id as string)
  if (response.isFailure) {
    router.push("/404")
  } else {
    squad.value = response.body
    squad.value = squad.value[0]
  }
}
fetchSquad()
</script>
