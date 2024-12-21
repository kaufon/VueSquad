import type { ApiResponse } from "../responses";

export interface ISquadService{
  register(name:string): Promise<ApiResponse<unknown>>
}
