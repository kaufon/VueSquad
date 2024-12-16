
<template>
  <div class="flex items-center justify-center w-full h-screen">
    <Card class="w-[350px]">
      <CardHeader>
        <CardTitle class="text-center">Sign up to VueSquad</CardTitle>
      </CardHeader>
      <form @submit="onSubmit">
        <CardContent class="space-y-3">
          <FormField v-slot="{ componentField }" name="name">
            <FormItem>
              <FormLabel>Name</FormLabel>
              <FormControl>
                <Input type="text" placeholder="Name" v-bind="componentField" />
              </FormControl>
            </FormItem>
            <FormMessage />
          </FormField>
          <FormField v-slot="{ componentField }" name="email">
            <FormItem>
              <FormLabel>Email</FormLabel>
              <FormControl>
                <Input type="email" placeholder="Email" v-bind="componentField" />
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
          <FormField v-slot="{ componentField }" name="password_confirmation">
            <FormItem>
              <FormLabel>Confirm your password</FormLabel>
              <FormControl>

                <Input type="password" placeholder="Password confirmation" v-bind="componentField" />
              </FormControl>
            </FormItem>
            <FormMessage />
          </FormField>
        </CardContent>
        <CardFooter>
          <Button type="submit" variant="default" class="flex-1">Submit</Button>
        </CardFooter>
        <p class="text-center text-sm pb-4">Already have an account? <strong>
            <RouterLink to="/login">Sign in</RouterLink>
          </strong></p>

      </form>
    </Card>
  </div>
</template>
<script setup lang="ts">
import { Card, CardContent, CardFooter, CardTitle, CardHeader } from '@/components/ui/card';
import Input from '@/components/ui/input/Input.vue';
import { FormField } from '@/components/ui/form';
import FormControl from '@/components/ui/form/FormControl.vue';
import FormItem from '@/components/ui/form/FormItem.vue';
import FormLabel from '@/components/ui/form/FormLabel.vue';
import { toTypedSchema } from '@vee-validate/zod';
import { useForm } from 'vee-validate';
import { z } from 'zod';
import FormMessage from '@/components/ui/form/FormMessage.vue';
import Button from '@/components/ui/button/Button.vue';
import { plainAxiosInstance } from '@/api/axios';
import { useToast } from '@/components/ui/toast';
const { toast } = useToast()
const formSchema = toTypedSchema(z.object({
  email: z.string().email().min(1),
  name: z.string().min(1),
  password: z.string().min(1),
  password_confirmation: z.string().min(1)
}).refine((data) => data.password === data.password_confirmation, {
  message: "Passwords are not the same",
  path: ["password_confirmation"]
}))
const { handleSubmit } = useForm({
  validationSchema: formSchema
})
const onSubmit = handleSubmit((values) => {
  plainAxiosInstance.post("/users", values)
    .then(() => {
      window.location.href = "/login"
    })
    .catch(function (error) {
      const errors = error.response.data;


      Object.keys(errors).forEach((key) => {
        const errorMessages = Array.isArray(errors[key]) ? errors[key] : [errors[key]];


        errorMessages.forEach((message) => {
          toast({
            variant: "destructive",
            title: key.toUpperCase(),
            description: message
          });
        });
      });
    });
});
</script>
