
export type SquadDto = {
  id?:string 
  name: string 
  owner_id: string 
  created_at: Date 
  updated_at: Date 
  users: Array<{id:string,name:string,email:string}>
}
