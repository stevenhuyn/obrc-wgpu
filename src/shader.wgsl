struct InputData {
  data: array<i32>,
}

struct OutputData {
  min_val: atomic<i32>,
  max_val: atomic<i32>,
  sum: atomic<i32>,
}

@group(0) @binding(0) var<storage, read> input: InputData;
@group(0) @binding(1) var<storage, read_write> output: OutputData;

@compute @workgroup_size(1)
fn main(@builtin(global_invocation_id) global_id: vec3<u32>) {
  let number = input.data[global_id.x];
  atomicMin(&output.min_val, number);
  atomicMax(&output.max_val, number);
  atomicAdd(&output.sum, number);
}
