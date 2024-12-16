<template>
  <div class="flex items-center justify-center w-full h-screen">
    <Card class="w-[350px] ">
      <CardHeader>
        <CardTitle class="text-center">Sign in to VueSquad</CardTitle>
      </CardHeader>
      <form @submit="onSubmit">
        <CardContent class="space-y-3">
          <FormField v-slot="{ componentField }" name="email">
            <FormItem>
              <FormLabel>Email</FormLabel>
              <FormControl>
                <Input type="text" placeholder="Email" v-bind="componentField" />
              </FormControl>
            </FormItem>
            <FormMessage />
          </FormField>
          <FormField v-slot="{ componentField }" name="password">
            <FormItem>
              <FormLabel>Password</FormLabel>
              <FormControl>
                <Input type="password" placeholder="Password" v-bind="componentField" />
              </FormControl>
            </FormItem>
            <FormMessage />
          </FormField>
        </CardContent>
        <CardFooter class="w-full">
          <Button type="submit" variant="default" class="flex-1">Submit</Button>
        </CardFooter>
        <p class="text-center text-sm pb-4">Does not have an account? <strong>
            <RouterLink to="/register">Sign up</RouterLink>
          </strong></p>
      </form>
    </Card>
  </div>
</template>
<script setup lang="ts">
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Card, CardHeader, CardTitle, CardFooter, CardContent } from '@/components/ui/card';
import { useForm } from 'vee-validate';
import { toTypedSchema } from '@vee-validate/zod';
import { z } from 'zod';
import { FormField, FormMessage, FormControl, FormLabel, FormItem } from '@/components/ui/form';
import { plainAxiosInstance } from '@/api/axios';
import { useToast } from '@/components/ui/toast';
import { RouterLink } from 'vue-router';
const { toast } = useToast()
const formSchema = toTypedSchema(z.object({
  email: z.string().email().min(1),
  password: z.string().min(1)
}))
const { handleSubmit } = useForm({
  validationSchema: formSchema
})
const onSubmit = handleSubmit((values) => {
  plainAxiosInstance.post("/auth/login", values).catch(function (error) {
    toast({ variant: "destructive", title: error.response.data.error })
  }).then(function (response) {
    const token = response.data.jwt
    localStorage.setItem("jwt", token)
  })

})
</script>
