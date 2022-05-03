class_name neural_network

var n_inputs
var n_layers
var act_func
var layers_size = 0
var x = [] #Inputs
var w = [] #Weights
var o = [] #Outputs
var b = [] #bias

func _init(number_inputs, number_layers, activation_function):
	n_inputs = number_inputs
	n_layers = number_layers
	act_func = activation_function
	for i in number_layers:
		b.append(0)

func add_layer(layer_index, number_inputs, number_neurons):
	w.append([])
	o.append([])
	for N in number_neurons:
		o[layer_index].append(0)
		var neurons = []
		for I in number_inputs:
			if (randi()%2) == 0:
				neurons.append((randi()%10 + 1) / 10.0)
			else:
				neurons.append(-(randi()%10 + 1) / 10.0)
		w[layer_index].append(neurons)

func mutation(ws):
	# Escolhe uma camada, neurornio e entrada.
	var L = randi() % n_layers + 0
	var N = randi() % w[L].size() + 0
	var I = randi() % w[L][N].size() + 0
	if (randi()%2) == 0:
		w[L][N][I] = ws[L][N][I] + (randi()%10 + 1) / 10.0
	else:
		w[L][N][I] = ws[L][N][I] - (randi()%10 + 1) / 10.0

func pulse(inputs):
	x = inputs
	for L in n_layers: #L = Camada
		if L == 0:
			for N in w[L].size(): #N = Neuronio
				for I in w[L][N].size():
					o[L][N] = o[L][N] + (w[L][N][I] * x[I])
				o[L][N] += b[L]
				o[L][N] = _act_func(o[L][N])
		else:
			for N in w[L].size(): #N = Neuronio
				for I in w[L-1].size():
					o[L][N] = o[L][N] + (w[L][N][I] * o[L-1][I])
				o[L][N] += b[L]
				o[L][N] = _act_func(o[L][N])
	return o[n_layers - 1]

func set_bias(bias):
	b = bias

func set_weights(ws):
	w = ws

func get_weights():
	return(w)

func get_outputs():
	return(o)

func _act_func(output):
	if output > 1:
		return 1
	else:
		return 0

func show_info():
	print(x)
	print(w)
	print(o)
	print(b)
