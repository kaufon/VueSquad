<template>
  <Table>
    <TableHeader>
      <TableRow>
        <TableHead class="w-[100px]">Name</TableHead>
        <TableHead>Email</TableHead>
      </TableRow>
    </TableHeader>
    <TableBody>
      <TableRow v-for="member in members">
        <TableCell>{{ member.name }}</TableCell>
        <TableCell>
          {{ member.email }}
        </TableCell>
      </TableRow>
    </TableBody>
  </Table>
</template>

<script setup lang="ts">
defineProps<{
  members: { id: string, name: string, email: string }[]
}>()
import { TableHeader, Table, TableRow, TableHead, TableBody, TableCell } from '@/components/ui/table';

</script>
